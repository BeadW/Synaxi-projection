"""
Evaluator that judges an agent's output against acceptance criteria.
Uses a Claude model (default Sonnet) to produce a quality score between 0 and 1.
"""

from __future__ import annotations

import os
import json
from typing import List, Dict, Any

try:
    import anthropic
except ImportError:
    anthropic = None

try:
    import litellm
except ImportError:
    litellm = None


class Evaluator:
    """Runs a lightweight evaluation of generated output.

    Returns a ``quality_score`` (0‑1) and a boolean indicating whether all
    acceptance criteria appear to be satisfied.
    """

    def __init__(self, model: str = "sonnet"):
        self.model = model
        self._client = None

    def _get_client(self):
        if self._client is None:
            if anthropic:
                api_key = os.environ.get("ANTHROPIC_API_KEY")
                if not api_key:
                    raise ValueError("ANTHROPIC_API_KEY not set")
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

    def evaluate(self, output: str, acceptance_criteria: List[str]) -> Dict[str, Any]:
        client = self._get_client()
        model_id = self._model_map().get(self.model, self._model_map()["sonnet"])
        criteria_text = "\n".join(f"- {c}" for c in acceptance_criteria)
        prompt = f"""
You are an expert evaluator. Given the following generated output and a list of acceptance criteria, provide a JSON object with:
  * "quality_score": a float between 0 and 1 indicating overall quality.
  * "passed": true if the output satisfies *all* criteria, false otherwise.

Generated output:
"""
        + output + "\n\nAcceptance criteria:\n" + criteria_text + "\n"

        if hasattr(client, 'messages'):
            response = client.messages.create(
                model=model_id,
                max_tokens=1024,
                messages=[{"role": "user", "content": prompt}]
            )
            content = response.content[0].text
        else:
            response = client.completion(
                model=model_id,
                messages=[{"role": "user", "content": prompt}],
                max_tokens=1024
            )
            content = response.choices[0].message.content

        try:
            result = json.loads(content)
        except json.JSONDecodeError:
            # Fallback: naive parsing – if we cannot decode, assign low score
            result = {"quality_score": 0.0, "passed": False}

        return {
            "quality_score": float(result.get("quality_score", 0.0)),
            "passed": bool(result.get("passed", False)),
        }
