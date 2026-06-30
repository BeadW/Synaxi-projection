"""
Strategy implementations for different execution modes.
Each strategy defines how to run the agent against a task.
"""

from .single import SingleModelStrategy
from .advisor import AdvisorStrategy
from .cascade import CascadeStrategy
from .parallel_vote import ParallelVoteStrategy
from .compressed import CompressedStrategy
from .speculative import SpeculativeStrategy

__all__ = [
    "SingleModelStrategy",
    "AdvisorStrategy",
    "CascadeStrategy",
    "ParallelVoteStrategy",
    "CompressedStrategy",
    "SpeculativeStrategy",
]