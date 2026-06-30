from __future__ import annotations

import json
import os
import shutil
import stat
import time
from pathlib import Path
from typing import Optional

STATE_DIR = Path.home() / '.synaxi-projection'
STATE_FILE = STATE_DIR / 'state.json'
BACKUP_DIR = STATE_DIR / 'backups'
USER_BIN = Path.home() / '.local' / 'bin'


def _load_state() -> dict:
    if not STATE_FILE.exists():
        return {}
    try:
        return json.loads(STATE_FILE.read_text())
    except Exception:
        return {}


def _save_state(state: dict) -> None:
    STATE_DIR.mkdir(parents=True, exist_ok=True)
    STATE_FILE.write_text(json.dumps(state, indent=2))


def _find_real_binary(name: str) -> Optional[str]:
    """Find the real binary, skipping any existing entry at USER_BIN (shim location)."""
    shim_location = USER_BIN / name
    shim_resolved = str(shim_location.resolve()) if shim_location.exists() else None
    for part in os.environ.get('PATH', '').split(':'):
        if not part:
            continue
        cand = Path(part) / name
        if not cand.exists() or not os.access(cand, os.X_OK):
            continue
        # Skip anything that resolves to the same file as the shim location
        try:
            resolved = str(cand.resolve())
        except Exception:
            resolved = str(cand)
        if shim_resolved and resolved == shim_resolved:
            continue
        if str(cand.resolve()) == str(shim_location.resolve()) if shim_location.exists() else False:
            continue
        return resolved
    return None


def wrap_claude(proxy_url: Optional[str] = None) -> dict:
    tool = 'claude'
    shim_path = USER_BIN / tool

    # Determine real binary path and how to restore on unwrap
    restore_type: str = 'none'
    restore_data: Optional[str] = None
    real_binary: Optional[str] = None

    if shim_path.is_symlink():
        # Symlink (e.g. Claude Code installs as ~/.local/bin/claude -> real executable)
        # Resolve to the actual binary and store the symlink target for restore
        restore_type = 'symlink'
        restore_data = str(os.readlink(shim_path))          # original link target
        real_binary = str(shim_path.resolve())              # actual executable on disk
        shim_path.unlink()                                  # remove symlink before writing shim
    elif shim_path.exists():
        # Regular file — back it up
        BACKUP_DIR.mkdir(parents=True, exist_ok=True)
        backup_path = BACKUP_DIR / f'{tool}.{int(time.time())}.bak'
        shutil.move(str(shim_path), str(backup_path))
        restore_type = 'backup'
        restore_data = str(backup_path)
        real_binary = str(backup_path)                      # binary is now at backup location
    else:
        # Nothing at shim location — find real binary elsewhere in PATH
        real_binary = _find_real_binary(tool) or shutil.which(tool)
        if not real_binary:
            raise RuntimeError('Could not find `claude` in PATH. Install Claude Code first.')
        restore_type = 'none'

    if not real_binary:
        raise RuntimeError('Could not determine real claude binary path.')

    USER_BIN.mkdir(parents=True, exist_ok=True)
    shim_script = "#!/usr/bin/env bash\nexec /usr/bin/env python3 -m synaxi_projection.shim \"$@\"\n"
    shim_path.write_text(shim_script)
    shim_path.chmod(shim_path.stat().st_mode | stat.S_IXUSR | stat.S_IXGRP | stat.S_IXOTH)

    state = {
        'tool': tool,
        'wrapped': True,
        'real_binary': real_binary,
        'shim_path': str(shim_path),
        'restore_type': restore_type,   # 'symlink' | 'backup' | 'none'
        'restore_data': restore_data,   # symlink target or backup path
        # legacy keys kept for compat
        'backup_path': restore_data if restore_type == 'backup' else None,
        'proxy_url': proxy_url,
        'wrapped_at': int(time.time()),
        'mode': 'projection-only',
    }
    _save_state(state)
    return state


def unwrap_claude() -> dict:
    state = _load_state()
    tool = state.get('tool', 'claude')
    shim_path = Path(state.get('shim_path', str(USER_BIN / tool)))

    if shim_path.exists() or shim_path.is_symlink():
        try:
            shim_path.unlink()
        except Exception:
            pass

    restore_type = state.get('restore_type', 'backup' if state.get('backup_path') else 'none')
    restore_data = state.get('restore_data') or state.get('backup_path')
    restored = False

    if restore_type == 'symlink' and restore_data:
        # Recreate the original symlink
        USER_BIN.mkdir(parents=True, exist_ok=True)
        os.symlink(restore_data, str(shim_path))
        restored = True
    elif restore_type == 'backup' and restore_data and Path(restore_data).exists():
        USER_BIN.mkdir(parents=True, exist_ok=True)
        shutil.move(restore_data, str(shim_path))
        restored = True

    _save_state({
        'tool': tool,
        'wrapped': False,
        'restored_backup': restored,
        'unwrapped_at': int(time.time()),
    })
    return {'restored': restored, 'restore_type': restore_type, 'tool': tool}


def status() -> dict:
    st = _load_state()
    active = bool(st.get('wrapped'))
    which = shutil.which('claude')
    return {
        'wrapped': active,
        'state_file': str(STATE_FILE),
        'which_claude': which,
        'real_binary': st.get('real_binary'),
        'shim_path': st.get('shim_path'),
        'mode': st.get('mode'),
        'proxy_url': st.get('proxy_url'),
    }


def doctor() -> dict:
    st = status()
    checks = {
        'claude_in_path': bool(st.get('which_claude')),
        'state_file_exists': STATE_FILE.exists(),
        'shim_exists': Path(st['shim_path']).exists() if st.get('shim_path') else False,
        'real_binary_exists': Path(st['real_binary']).exists() if st.get('real_binary') else False,
        'user_bin_on_path': str(USER_BIN) in os.environ.get('PATH', '').split(':'),
    }
    # Only require wrapped-state checks when actually wrapped
    ok = all(
        v for k, v in checks.items()
        if k not in ('state_file_exists', 'shim_exists', 'real_binary_exists') or st.get('wrapped')
    )
    return {'ok': ok, 'checks': checks, 'status': st}
