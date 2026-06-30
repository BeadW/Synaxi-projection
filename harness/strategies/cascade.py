"""
Cascade strategy: start with Haiku; if quality < threshold, escalate to Sonnet; then Opus.
"""

from __future__ import annotations

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


class CascadeStrategy(BaseStrategy):
    """Run the task with progressively stronger models until quality threshold is met."""

    MODEL_ORDER = ["haiku", "sonnet", "opus"]
    QUALITY_THRESHOLD = 0.7

    def __init__(self):
        self._client = None
        self._evaluator = None

    def _get_client(self):
        if self._client is None:
            if anthropic:
                api_key = os.environ.get("ANTHROPIC_API_KEY")
                if not api_key:
                    raise ValueError("ANTHROPIC_API_KEY required")
                self._client = anthropic.Anthropic(api_key=api_key)
            elif litellm:
                self._client = litellm
            else:
                raise RuntimeError("No LLM client available")
        return self._client

    def _model_map(self) -> Dict[str, str]:
        return {
            "haiku": "claude-3-5-haiku-20241022",
            "sonnet": "claude-3-5-sonnet-20241022",
            "opus": "claude-3-5-opus-20241022",
        }

    def execute(self, task_context: str, acceptance_criteria: List[str]) -> Dict[str, Any]:
        client = self._get_client()
        last_output = ""
        total_prompt = 0
        total_completion = 0
        models_used = []

        for model_name in self.MODEL_ORDER:
            model_id = self._model_map()[model_name]
            prompt = self._build_prompt(task_context, acceptance_criteria, last_output)
            if hasattr(client, 'messages'):
                resp = client.messages.create(
                    model=model_id,
                    max_tokens=8192,
                    messages=[{"role": "user", "content": prompt}]
                )
                output = resp.content[0].text
                usage = resp.usage
            else:
                resp = client.completion(
                    model=model_id,
                    messages=[{"role": "user", "content": prompt}],
                    max_tokens=8192
                )
                output = resp.choices[0].message.content
                usage = resp.usage

            last_output = output
            models_used.append(model_name)
            total_prompt += usage.input_tokens
            total_completion += usage.output_tokens

            # Evaluate quality
            quality = self._quick_quality_check(output, acceptance_criteria)
            if quality >= self.QUALITY_THRESHOLD:
                break

        return {
            "output": last_output,
            "model": "+".join(models_used),
            "strategy": "cascade",
            "prompt_tokens": total_prompt,
            "completion_tokens": total_completion,
        }

    def _quick_quality_check(self, output: str, criteria: List[str]) -> float:
        """Very lightweight heuristic – in real use call Evaluator."""
        # Count how many criteria keywords appear in output
        hits = sum(1 for c in criteria if any(w.lower() in output.lower() for w in c.split()))
        return min(hits / max(len(criteria), 1), 1.0)

    def _build_prompt(self, context: str, criteria: List[str], prev: str) -> str:
        crit = "\n".join(f"- {c}" for c in criteria)
        if prev:
            return f"""Previous attempt (insufficient quality):
{prev}

Retry the task with higher quality:
Context:
{context}

Criteria:
{crit}"""
        return f"""Complete the task:\nContext:\n{context}\n\nCriteria:\n{crit}"""
