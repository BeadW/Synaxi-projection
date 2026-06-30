"""
Base strategy class that all execution strategies inherit from.
This defines the interface for interacting with LLM APIs.
"""

from __future__ import annotations

from abc import ABC, abstractmethod
from typing import Dict, Any, List


class BaseStrategy(ABC):
    """Abstract base class for execution strategies."""

    @abstractmethod
    def execute(self, task_context: str, acceptance_criteria: List[str]) -> Dict[str, Any]:
        """Execute the strategy against the given task context and criteria.

        Parameters
        ----------
        task_context : str
            The context string extracted from the .feature file's Background block.
        acceptance_criteria : List[str]
            List of acceptance criteria from the .feature file.

        Returns
        -------
        Dict[str, Any]
            Execution result containing at minimum:
            - ``output``: the generated text
            - ``prompt_tokens``: int
            - ``completion_tokens``: int
            - ``strategy``: str
        """
        raise NotImplementedError