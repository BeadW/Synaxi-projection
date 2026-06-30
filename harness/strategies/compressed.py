"""
Compressed strategy: apply Synaxi token compression before dispatching to a model.
Compression is a no-op stub until the Synaxi SDK is integrated.
"""

from __future__ import annotations

import os
from typing import Dict, Any, List

try:
    import anthropic
except ImportError:
    anthropic = None

from .base import BaseStrategy


def _synaxi_compress(text: str) -> tuple[str, float]:
    """
    Compress text using Synaxi. Returns (compressed_text, compression_ratio).
    Stub: returns the original text with ratio=1.0 until Synaxi SDK is available.
    """
    try:
        import synaxi  # noqa: F401
        compressed = synaxi.compress(text)
        ratio = len(compressed) / max(len(text), 1)
        return compressed, ratio
    except ImportError:
        return text, 1.0


class CompressedStrategy(BaseStrategy):
    """Run the task after compressing the prompt with Synaxi."""

    MODEL_MAP = {
        "haiku":  "claude-haiku-4-5-20251001",
        "sonnet": "claude-sonnet-4-6",
        "opus":   "claude-opus-4-8",
    }

    def __init__(self, execution_model: str = "sonnet", advisor_model: str = "opus"):
        self.execution_model = execution_model
        self.advisor_model = advisor_model
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
        model_id = self.MODEL_MAP.get(self.execution_model, self.MODEL_MAP["sonnet"])

        prompt = self._build_prompt(task_context, acceptance_criteria)
        compressed_prompt, compression_ratio = _synaxi_compress(prompt)

        resp = client.messages.create(
            model=model_id, max_tokens=8192,
            messages=[{"role": "user", "content": compressed_prompt}]
        )

        return {
            "output": resp.content[0].text,
            "model": model_id,
            "strategy": f"compressed-{self.execution_model}",
            "prompt_tokens": resp.usage.input_tokens,
            "completion_tokens": resp.usage.output_tokens,
            "compression_ratio": compression_ratio,
        }

    def _build_prompt(self, context: str, criteria: List[str]) -> str:
        crit = "\n".join(f"- {c}" for c in criteria)
        return (
            f"Complete the task:\n{context}\n\n"
            f"Acceptance criteria:\n{crit}\n\n"
            "Return only the implementation as a Python code block."
        )
