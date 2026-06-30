"""
Speculative draft strategy: Haiku drafts fast, Opus corrects if needed.
Analogous to speculative decoding but at the agent level.
"""

from __future__ import annotations

import os
from typing import Dict, Any, List

try:
    import anthropic
except ImportError:
    anthropic = None

from .base import BaseStrategy

QUALITY_THRESHOLD = 0.75


class SpeculativeStrategy(BaseStrategy):
    """Haiku produces a cheap draft; Opus reviews and corrects if quality < threshold."""

    MODEL_MAP = {
        "haiku": "claude-haiku-4-5-20251001",
        "opus":  "claude-opus-4-8",
    }

    def __init__(self):
        self._client = None

    def _get_client(self):
        if self._client is None:
            api_key = os.getenv("ANTHROPIC_API_KEY")
            if not api_key:
                raise RuntimeError("ANTHROPIC_API_KEY not set")
            self._client = anthropic.Anthropic(api_key=api_key)
        return self._client

    def execute(self, task_context: str, acceptance_criteria: List[str]) -> Dict[str, Any]:
        client = self._get_client()
        prompt = self._build_prompt(task_context, acceptance_criteria)

        # Draft phase: Haiku
        draft_resp = client.messages.create(
            model=self.MODEL_MAP["haiku"], max_tokens=4096,
            messages=[{"role": "user", "content": prompt}]
        )
        draft = draft_resp.content[0].text
        draft_quality = self._heuristic_quality(draft, acceptance_criteria)

        total_input = draft_resp.usage.input_tokens
        total_output = draft_resp.usage.output_tokens
        final_output = draft
        models_used = ["haiku"]

        if draft_quality < QUALITY_THRESHOLD:
            # Correction phase: Opus
            correction_prompt = (
                f"Review and improve this draft response.\n\n"
                f"Original task:\n{task_context}\n\n"
                f"Draft response:\n{draft}\n\n"
                f"Acceptance criteria:\n" + "\n".join(f"- {c}" for c in acceptance_criteria) +
                "\n\nProvide the corrected implementation as a Python code block."
            )
            opus_resp = client.messages.create(
                model=self.MODEL_MAP["opus"], max_tokens=8192,
                messages=[{"role": "user", "content": correction_prompt}]
            )
            final_output = opus_resp.content[0].text
            total_input += opus_resp.usage.input_tokens
            total_output += opus_resp.usage.output_tokens
            models_used.append("opus")

        return {
            "output": final_output,
            "model": "+".join(models_used),
            "strategy": "speculative",
            "prompt_tokens": total_input,
            "completion_tokens": total_output,
        }

    def _heuristic_quality(self, output: str, criteria: List[str]) -> float:
        hits = sum(
            1 for c in criteria
            if any(w.lower() in output.lower() for w in c.split() if len(w) > 3)
        )
        return hits / max(len(criteria), 1)

    def _build_prompt(self, context: str, criteria: List[str]) -> str:
        crit = "\n".join(f"- {c}" for c in criteria)
        return (
            f"Complete the task:\n{context}\n\nCriteria:\n{crit}\n\n"
            "Return only the implementation as a Python code block."
        )
