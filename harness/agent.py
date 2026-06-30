"""
Agent executor: uses the Anthropic Messages API directly.
Implements a simple tool-use loop so multi-turn sandbox tasks work without
the Claude Code CLI session limit.
"""

from __future__ import annotations

import json
import os
import subprocess
import time
from pathlib import Path
from typing import Dict, List, Optional

try:
    from dotenv import load_dotenv
    load_dotenv(Path(__file__).parent.parent / ".env")
except ImportError:
    pass

import anthropic

DEFAULT_MODEL = "sonnet"

MODEL_IDS: dict[str, str] = {
    "haiku":  "claude-haiku-4-5-20251001",
    "sonnet": "claude-sonnet-4-6",
    "opus":   "claude-opus-4-8",
}

# Per-token pricing (USD). Update if Anthropic changes rates.
_PRICING: dict[str, tuple[float, float]] = {
    "claude-haiku-4-5-20251001": (0.80 / 1_000_000,  4.00 / 1_000_000),
    "claude-sonnet-4-6":         (3.00 / 1_000_000, 15.00 / 1_000_000),
    "claude-opus-4-8":           (15.0 / 1_000_000, 75.00 / 1_000_000),
}

_TOOLS: list[dict] = [
    {
        "name": "read_file",
        "description": "Read the full contents of a file in the working directory.",
        "input_schema": {
            "type": "object",
            "properties": {
                "path": {"type": "string", "description": "Path relative to the sandbox root"}
            },
            "required": ["path"],
        },
    },
    {
        "name": "write_file",
        "description": "Write (overwrite) a file in the working directory.",
        "input_schema": {
            "type": "object",
            "properties": {
                "path":    {"type": "string"},
                "content": {"type": "string"},
            },
            "required": ["path", "content"],
        },
    },
    {
        "name": "run_command",
        "description": (
            "Run a shell command in the sandbox working directory and return "
            "stdout + stderr (truncated to 2000 chars)."
        ),
        "input_schema": {
            "type": "object",
            "properties": {
                "command": {"type": "string"}
            },
            "required": ["command"],
        },
    },
]


def _execute_tool(name: str, inputs: dict, cwd: str) -> str:
    """Run a tool call and return its string result."""
    try:
        if name == "read_file":
            p = Path(cwd) / inputs["path"]
            return p.read_text() if p.exists() else f"Error: {inputs['path']} not found"

        if name == "write_file":
            p = Path(cwd) / inputs["path"]
            p.parent.mkdir(parents=True, exist_ok=True)
            p.write_text(inputs["content"])
            return f"Written {len(inputs['content'])} bytes to {inputs['path']}"

        if name == "run_command":
            r = subprocess.run(
                inputs["command"],
                shell=True,
                cwd=cwd,
                capture_output=True,
                text=True,
                timeout=60,
            )
            out = (r.stdout + r.stderr)[:2000]
            return f"exit={r.returncode}\n{out}"

        return f"Unknown tool: {name}"
    except Exception as exc:
        return f"Tool error: {exc}"


def run_task(
    prompt: str,
    model: str = DEFAULT_MODEL,
    max_tokens: int = 8192,
    cwd: Optional[str] = None,
    timeout: int = 300,
    max_turns: int = 40,
) -> Dict:
    """
    Execute a task via the Anthropic Messages API and return metrics.

    Parameters
    ----------
    prompt    : Task prompt.
    model     : Model alias ('haiku', 'sonnet', 'opus') or full model ID.
    cwd       : Working directory for file/command tools (enables tool use).
    timeout   : Wall-clock seconds before aborting.
    max_turns : Maximum agentic loop iterations.

    Returns
    -------
    dict with keys: response, model, input_tokens, output_tokens,
                    cost_usd, elapsed_s, num_turns, tool_call_count
    """
    api_key = os.environ.get("ANTHROPIC_API_KEY")
    if not api_key:
        raise RuntimeError(
            "ANTHROPIC_API_KEY not set. Add it to .env or export it in your shell."
        )

    model_id = MODEL_IDS.get(model, model)
    client = anthropic.Anthropic(api_key=api_key)

    use_tools = cwd is not None
    messages: List[dict] = [{"role": "user", "content": prompt}]

    total_input = 0
    total_output = 0
    num_turns = 0
    tool_call_count = 0
    response_text = ""
    t0 = time.time()

    for _ in range(max_turns):
        if time.time() - t0 > timeout:
            break

        kwargs: dict = {
            "model":      model_id,
            "max_tokens": max_tokens,
            "messages":   messages,
        }
        if use_tools:
            kwargs["tools"] = _TOOLS

        resp = client.messages.create(**kwargs)

        num_turns += 1
        total_input  += resp.usage.input_tokens
        total_output += resp.usage.output_tokens

        messages.append({"role": "assistant", "content": resp.content})

        if resp.stop_reason == "end_turn":
            for block in resp.content:
                if hasattr(block, "text"):
                    response_text = block.text
            break

        if resp.stop_reason == "tool_use":
            tool_results = []
            for block in resp.content:
                if block.type == "tool_use":
                    tool_call_count += 1
                    result = _execute_tool(block.name, block.input, cwd)
                    tool_results.append({
                        "type":        "tool_result",
                        "tool_use_id": block.id,
                        "content":     result,
                    })
            messages.append({"role": "user", "content": tool_results})

    elapsed = round(time.time() - t0, 2)

    in_price, out_price = _PRICING.get(model_id, (3.0 / 1_000_000, 15.0 / 1_000_000))
    cost_usd = total_input * in_price + total_output * out_price

    return {
        "response":        response_text,
        "model":           model,
        "input_tokens":    total_input,
        "output_tokens":   total_output,
        "cost_usd":        round(cost_usd, 8),
        "elapsed_s":       elapsed,
        "num_turns":       num_turns,
        "tool_call_count": tool_call_count,
    }
