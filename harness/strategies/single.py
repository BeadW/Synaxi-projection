"""
Single model execution strategy.
Runs the entire task on one model (Haiku, Sonnet, or Opus).
"""

from __future__ import annotations

import os
from typing import Dict, Any, List
from abc import ABC, abstractmethod

# Use the same Anthropic client that the project depends on
try:
    import anthropic
except ImportError:
    anthropic = None

try:
    import litellm
except ImportError:
    litellm = None


class BaseStrategy(ABC):
    """Base class for all execution strategies."""

    @abstractmethod
    def execute(self, task_context: str, acceptance_criteria: List[str]) -> Dict[str, Any]:
        """Execute the strategy and return result with metrics."""
        pass


class SingleModelStrategy(BaseStrategy):
    """
    Run the task on a single model throughout.
    Model is specified at initialization (haiku/sonnet/opus).
    """

    def __init__(self, model_name: str = "sonnet"):
        self.model_name = model_name
        self._client = None

    def _get_client(self):
        """Lazy initialization of the Anthropic client."""
        if self._client is None:
            api_key = os.getenv("ANTHROPIC_API_KEY")
            if not api_key:
                raise RuntimeError("ANTHROPIC_API_KEY environment variable not set")
            self._client = anthropic.Anthropic(api_key=api_key)
        return self._client

    def _model_map(self) -> Dict[str, str]:
        """Map strategy model names to actual model IDs."""
        return {
            "haiku": "claude-3-5-haiku-20241022",
            "sonnet": "claude-3-5-sonnet-20241022",
            "opus": "claude-3-5-opus-20241022",
        }

    def execute(self, task_context: str, acceptance_criteria: List[str]) -> Dict[str, Any]:
        """Execute the task on the configured single model."""
        client = self._get_client()
        model_id = self._model_map().get(self.model_name, self._model_map()["sonnet"])

        # Build the prompt
        prompt = self._build_prompt(task_context, acceptance_criteria)

        # Execute
        response = client.messages.create(
            model=model_id,
            max_tokens=8192,
            messages=[{"role": "user", "content": prompt}]
        )
        content = response.content[0].text if response.content else ""
        usage = response.usage

        return {
            "output": content,
            "prompt_tokens": usage.input_tokens,
            "completion_tokens": usage.output_tokens,
            "model": model_id,
            "strategy": f"single-{self.model_name}",
        }

    def _build_prompt(self, context: str, criteria: List[str]) -> str:
        """Build the agent prompt from task context and acceptance criteria."""
        criteria_text = "\n".join(f"- {c}" for c in criteria)
        return f"""You are a coding agent. Complete the following task:

Context:
{context}

Acceptance Criteria:
{criteria_text}

Complete the task and provide your response. Your output will be evaluated against the acceptance criteria."""