from __future__ import annotations

import argparse
import json
import sys

from .wrapper import doctor, status, unwrap_claude, wrap_claude


def main() -> None:
    parser = argparse.ArgumentParser(prog="synaxi-projection")
    sub = parser.add_subparsers(dest="cmd", required=True)

    p_wrap = sub.add_parser("wrap", help="Wrap Claude Code with projection proxy")
    p_wrap.add_argument("tool", choices=["claude"])
    p_wrap.add_argument(
        "--upstream",
        default="https://api.anthropic.com",
        help="Upstream API base URL. Use http://127.0.0.1:11434 for Ollama. (default: Anthropic)",
    )
    p_wrap.add_argument("--port", type=int, default=8787, help="Local proxy port (default: 8787)")
    p_wrap.add_argument("--no-proxy", action="store_true", help="Reuse already-running proxy")
    p_wrap.add_argument("claude_args", nargs=argparse.REMAINDER, help="Extra args passed to claude")

    p_unwrap = sub.add_parser("unwrap", help="Remove proxy config and restore settings")
    p_unwrap.add_argument("tool", choices=["claude"])

    sub.add_parser("status", help="Show wrapper/proxy status")
    sub.add_parser("doctor", help="Run health checks")

    args = parser.parse_args()

    if args.cmd == "wrap":
        # Filter out leading '--' that argparse REMAINDER sometimes includes
        extra = [a for a in (args.claude_args or []) if a != "--"]
        wrap_claude(
            upstream=args.upstream,
            port=args.port,
            claude_args=tuple(extra),
            no_proxy=args.no_proxy,
        )
        return  # wrap_claude raises SystemExit; this is unreachable

    if args.cmd == "unwrap":
        out = unwrap_claude()
        print(json.dumps(out, indent=2))
        print("\n[synaxi-projection] unwrapped claude.")
        return

    if args.cmd == "status":
        print(json.dumps(status(), indent=2))
        return

    if args.cmd == "doctor":
        out = doctor()
        print(json.dumps(out, indent=2))
        if not out.get("ok"):
            sys.exit(1)
        return


if __name__ == "__main__":
    main()
