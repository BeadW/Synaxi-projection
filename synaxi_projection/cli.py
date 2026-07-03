from __future__ import annotations

import argparse
import json
import sys

from .wrapper import doctor, status, unwrap_claude, wrap_claude


def main() -> None:
    parser = argparse.ArgumentParser(prog="synaxi-projection")
    sub = parser.add_subparsers(dest="cmd", required=True)

    p_wrap = sub.add_parser("wrap", help="Wrap Claude Code with projection proxy")
    p_wrap.add_argument("--upstream", default="https://api.anthropic.com",
                        help="Upstream URL (default: Anthropic). Ollama: http://127.0.0.1:11434")
    p_wrap.add_argument("--model", default="",
                        help="Model name to send to Ollama (e.g. gemma4:latest, qwen2.5-coder:7b)")
    p_wrap.add_argument("--port", type=int, default=8787, help="Local proxy port (default: 8787)")
    p_wrap.add_argument("--no-proxy", action="store_true", help="Reuse already-running proxy")
    p_wrap.add_argument("--agent", default="synaxi-chat",
                        help="Interactive agent to launch (default: synaxi-chat, the tool-free "
                             "chat orchestrator that delegates coding to the projected worker). "
                             "Only injected when the agent is defined on disk.")
    p_wrap.add_argument("--no-agent", action="store_true",
                        help="Launch plain Claude Code with no agent (overrides --agent)")

    sub.add_parser("unwrap", help="Remove proxy config and restore settings")
    sub.add_parser("status", help="Show wrapper/proxy status")
    sub.add_parser("doctor", help="Run health checks")

    # parse_known_args so that flags appearing after 'claude' are ours, not claude's
    args, remaining = parser.parse_known_args()

    if args.cmd == "wrap":
        # strip 'claude' positional from remaining; everything else goes to claude binary
        claude_args = tuple(a for a in remaining if a != "claude")
        agent = "" if args.no_agent else args.agent
        wrap_claude(
            upstream=args.upstream,
            port=args.port,
            claude_args=claude_args,
            no_proxy=args.no_proxy,
            model=args.model,
            agent=agent,
        )
        return

    if remaining:
        parser.error(f"unrecognized arguments: {' '.join(remaining)}")

    if args.cmd == "unwrap":
        print(json.dumps(unwrap_claude(), indent=2))
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
