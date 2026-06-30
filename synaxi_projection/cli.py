from __future__ import annotations

import argparse
import json
import sys

from .wrapper import doctor, status, unwrap_claude, wrap_claude


def main() -> None:
    parser = argparse.ArgumentParser(prog='synaxi-projection')
    sub = parser.add_subparsers(dest='cmd', required=True)

    p_wrap = sub.add_parser('wrap', help='Wrap Claude Code with projection shim')
    p_wrap.add_argument('tool', choices=['claude'])
    p_wrap.add_argument('--proxy-url', default=None, help='Optional proxy URL (e.g. http://127.0.0.1:8082)')

    p_unwrap = sub.add_parser('unwrap', help='Remove wrapper and restore original binary')
    p_unwrap.add_argument('tool', choices=['claude'])

    sub.add_parser('status', help='Show wrapper status')
    sub.add_parser('doctor', help='Run wrapper health checks')

    args = parser.parse_args()

    if args.cmd == 'wrap':
        out = wrap_claude(proxy_url=args.proxy_url)
        print(json.dumps(out, indent=2))
        print('\n[synaxi-projection] wrapped claude.')
        print('[synaxi-projection] ensure ~/.local/bin is on PATH for this shell.')
        return

    if args.cmd == 'unwrap':
        out = unwrap_claude()
        print(json.dumps(out, indent=2))
        print('\n[synaxi-projection] unwrapped claude.')
        return

    if args.cmd == 'status':
        print(json.dumps(status(), indent=2))
        return

    if args.cmd == 'doctor':
        out = doctor()
        print(json.dumps(out, indent=2))
        if not out.get('ok'):
            sys.exit(1)
        return


if __name__ == '__main__':
    main()
