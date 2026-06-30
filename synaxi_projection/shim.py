
from __future__ import annotations

import json
import os
import sys
from pathlib import Path

STATE_FILE = Path.home() / '.synaxi-projection' / 'state.json'


def _load_state() -> dict:
    if not STATE_FILE.exists():
        return {}
    try:
        return json.loads(STATE_FILE.read_text())
    except Exception:
        return {}


def main() -> None:
    st = _load_state()
    real = st.get('real_binary')
    if not real:
        print('[synaxi-projection] wrapper state missing real binary; run: synaxi-projection wrap claude', file=sys.stderr)
        sys.exit(2)

    env = os.environ.copy()
    env['SYNAXI_PROJECTION_ENABLED'] = '1'
    env['SYNAXI_PROJECTION_MODE'] = 'projection-only'

    proxy_url = st.get('proxy_url')
    if proxy_url:
        env['HTTPS_PROXY'] = proxy_url
        env['HTTP_PROXY'] = proxy_url

    os.execvpe(real, [real, *sys.argv[1:]], env)


if __name__ == '__main__':
    main()
