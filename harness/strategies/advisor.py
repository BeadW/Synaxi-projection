"""
Advisor strategy: Uses Opus for planning/evaluation and executes on Sonnet/Haiku.
"""

from __future__ import annotations

import json
import os
from typing import Dict, Any, List

try:
    import anthropic
except ImportError:
    anthropic = None

try:
    import litellm
except ImportError:
    litellm = None

from .base import BaseStrategy


class AdvisorStrategy(BaseStrategy):
    """Implements the advisor strategy: Opus plans, Sonnet/Haiku executes."""

    MODEL_MAP = {
        "haiku": "claude-3-5-haiku-20241022",
        "sonnet": "claude-3-5-sonnet-20241022",
        "opus": "claude-3-5-opus-20241022",
    }

    def __init__(self, execution_model: str = "sonnet"):
        self.execution_model = execution_model
        self._client = None

    def _get_client(self):
        """Initialize the client using credentials from environment."""
        if self._client is None:
            api_key = os.getenv("ANTHROPIC_API_KEY")
            if not api_key:
                raise RuntimeError("ANTHROPIC_API_KEY environment variable not set")
            self._client = anthropic.Anthropic(api_key=api_key)
        return self._client

    def execute(self, task_context: str, acceptance_criteria: List[str]) -> Dict[str, Any]:
        """1. Use Opus for planning, 2. Execute with selected model, 3. Return metrics."""
        client = self._get_client()
        plan_prompt = f"""Plan task execution for: {task_context}
Acceptance criteria: {', '.join(acceptance_criteria)}
Return a JSON plan with sequential steps."""

        # Plan with Opus
        plan_resp = client.messages.create(
            model=self.MODEL_MAP["opus"],
            max_tokens=4096,
            messages=[{"role": "user", "content": plan_prompt}]
        )
        plan_text = plan_resp.content[0].text

        # Execute with the designated model
        exec_prompt = f"""Execute this plan:
{plan_text}

Context:
{task_context}

Meet the acceptance criteria: {', '.join(acceptance_criteria)}"""
        exec_resp = client.messages.create(
            model=self.MODEL_MAP[self.execution_model],
            max_tokens=8192,
            messages=[{"role": "user", "content": exec_prompt}]
        )

        return {
            "output": exec_resp.content[0].text,
            "model": self.MODEL_MAP[self.execution_model],
            "strategy": "advisor",
            "prompt_tokens": exec_resp.usage.input_tokens,
            "completion_tokens": exec_resp.usage.output_tokens,
        }