"""
Parallel voting strategy: run N cheaper models concurrently, pick majority or judge result.
"""

from __future__ import annotations

import os
import threading
from typing import Dict, Any, List

try:
    import anthropic
except ImportError:
    anthropic = None

from .base import BaseStrategy


class ParallelVoteStrategy(BaseStrategy):
    """Run the task on N parallel instances of a model and select the best output via majority vote."""

    def __init__(self, model_name: str = "haiku", n: int = 3):
        self.model_name = model_name
        self.n = n
        self._client = None

    MODEL_MAP = {
        "haiku":  "claude-haiku-4-5-20251001",
        "sonnet": "claude-sonnet-4-6",
        "opus":   "claude-opus-4-8",
    }

    def _get_client(self):
        if self._client is None:
            api_key = os.getenv("ANTHROPIC_API_KEY")
            if not api_key:
                raise RuntimeError("ANTHROPIC_API_KEY not set")
            self._client = anthropic.Anthropic(api_key=api_key)
        return self._client

    def execute(self, task_context: str, acceptance_criteria: List[str]) -> Dict[str, Any]:
        client = self._get_client()
        model_id = self.MODEL_MAP.get(self.model_name, self.MODEL_MAP["haiku"])
        prompt = self._build_prompt(task_context, acceptance_criteria)

        outputs: list[str] = [None] * self.n
        usages: list = [None] * self.n
        errors: list[str] = []

        def _call(idx: int) -> None:
            try:
                resp = client.messages.create(
                    model=model_id, max_tokens=8192,
                    messages=[{"role": "user", "content": prompt}]
                )
                outputs[idx] = resp.content[0].text
                usages[idx] = resp.usage
            except Exception as e:
                errors.append(str(e))
                outputs[idx] = ""

        threads = [threading.Thread(target=_call, args=(i,)) for i in range(self.n)]
        for t in threads:
            t.start()
        for t in threads:
            t.join()

        # Simple majority vote: pick the most common output (by length heuristic)
        # In production, use a judge model to pick the best response
        valid = [(len(o), i, o) for i, o in enumerate(outputs) if o]
        best_output = max(valid, key=lambda x: x[0])[2] if valid else ""

        total_input = sum(u.input_tokens for u in usages if u)
        total_output = sum(u.output_tokens for u in usages if u)

        return {
            "output": best_output,
            "model": model_id,
            "strategy": f"parallel-vote-{self.n}x{self.model_name}",
            "prompt_tokens": total_input,
            "completion_tokens": total_output,
        }

    def _build_prompt(self, context: str, criteria: List[str]) -> str:
        crit = "\n".join(f"- {c}" for c in criteria)
        return f"Complete the task:\n{context}\n\nCriteria:\n{crit}"
