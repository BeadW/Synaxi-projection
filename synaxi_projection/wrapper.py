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
    shim_path = str((USER_BIN / name).resolve()) if (USER_BIN / name).exists() else None
    for part in os.environ.get('PATH', '').split(':'):
        if not part:
            continue
        cand = Path(part) / name
        if not cand.exists() or not os.access(cand, os.X_OK):
            continue
        try:
            resolved = str(cand.resolve())
        except Exception:
            resolved = str(cand)
        if shim_path and resolved == shim_path:
            continue
        return resolved
    return shutil.which(name)


def wrap_claude(proxy_url: Optional[str] = None) -> dict:
    tool = 'claude'
    real = _find_real_binary(tool)
    if not real:
        raise RuntimeError('Could not find `claude` in PATH. Install Claude Code first.')

    USER_BIN.mkdir(parents=True, exist_ok=True)
    shim_path = USER_BIN / tool

    backup_path = None
    if shim_path.exists() and not shim_path.is_symlink():
        BACKUP_DIR.mkdir(parents=True, exist_ok=True)
        backup_path = BACKUP_DIR / f'{tool}.{int(time.time())}.bak'
        shutil.move(str(shim_path), str(backup_path))

    shim_script = "#!/usr/bin/env bash\nexec /usr/bin/env python3 -m synaxi_projection.shim \"$@\"\n"
    shim_path.write_text(shim_script)
    shim_path.chmod(shim_path.stat().st_mode | stat.S_IXUSR | stat.S_IXGRP | stat.S_IXOTH)

    state = {
        'tool': tool,
        'wrapped': True,
        'real_binary': real,
        'shim_path': str(shim_path),
        'backup_path': str(backup_path) if backup_path else None,
        'proxy_url': proxy_url,
        'wrapped_at': int(time.time()),
        'mode': 'projection-only',
    }
    _save_state(state)
    return state


def unwrap_claude() -> dict:
    state = _load_state()
    tool = state.get('tool', 'claude')
    shim_path = Path(state.get('shim_path', USER_BIN / tool))

    if shim_path.exists():
        try:
            shim_path.unlink()
        except Exception:
            pass

    backup_path = state.get('backup_path')
    restored = False
    if backup_path and Path(backup_path).exists():
        USER_BIN.mkdir(parents=True, exist_ok=True)
        shutil.move(backup_path, str(USER_BIN / tool))
        restored = True

    _save_state({
        'tool': tool,
        'wrapped': False,
        'restored_backup': restored,
        'unwrapped_at': int(time.time()),
    })
    return {'restored_backup': restored, 'tool': tool}


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
    ok = all(v for k, v in checks.items() if k != 'real_binary_exists' or st.get('wrapped'))
    return {'ok': ok, 'checks': checks, 'status': st}
