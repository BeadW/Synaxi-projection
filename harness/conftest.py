import pytest
from harness.recorder import record
from harness.steps.common import *  # noqa: F401,F403 — registers all step definitions


@pytest.fixture
def run_context():
    ctx = {}
    yield ctx
    if ctx.get("task_id") and ctx.get("result"):
        r = ctx["result"]
        record({
            "task_id": ctx["task_id"],
            "strategy": ctx.get("strategy", "single-sonnet"),
            "category": ctx.get("category", ""),
            "complexity": ctx.get("complexity", ""),
            "model": r["model"],
            "input_tokens": r["input_tokens"],
            "output_tokens": r["output_tokens"],
            "elapsed_s": r["elapsed_s"],
            "cost_usd": r.get("cost_usd", 0.0),
            "passed": ctx.get("passed", None),
        })
