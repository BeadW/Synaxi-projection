"""
Harness runner that executes Gherkin feature files and records results.
Parses .feature files, runs agents under different strategies, and records outcomes.
"""

from __future__ import annotations

import json
import os
from dataclasses import dataclass, asdict
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict, List, Optional

# Feature file format parser
@dataclass
class FeatureTask:
    """Parsed representation of a .feature file."""
    task_id: str
    category: str
    complexity: str
    scenario_name: str
    context: str
    acceptance_criteria: List[str]


def parse_feature_file(feature_path: Path) -> FeatureTask:
    """Parse a .feature file and extract task metadata."""
    content = feature_path.read_text()
    lines = content.split('\n')

    # Extract feature name (first line after Feature:)
    feature_name = ""
    for i, line in enumerate(lines):
        if line.strip().startswith("Feature:"):
            feature_name = line.split(":", 1)[1].strip()
            break

    # Extract category and complexity from file path
    # e.g., features/code/debug/t1_off_by_one.feature
    relative_path = feature_path.relative_to("features")
    parts = list(relative_path.parts)
    category = "/".join(parts[:-1])  # e.g., "code/debug"
    task_id = feature_path.stem  # e.g., "t1_off_by_one"

    # Extract complexity tier from filename (t1, t2, t3)
    tier = parts[-1][0]  # First character of filename is tier
    complexity_map = {"1": "T1", "2": "T2", "3": "T3"}
    complexity = complexity_map.get(tier, "T1")

    # Extract context from Background block
    context = ""
    in_background = False
    for line in lines:
        if "Background:" in line:
            in_background = True
            continue
        if in_background and '"""' in line:
            # Skip the opening marker
            if context:
                break
            continue
        if in_background:
            context += line + "\n"

    # Extract acceptance criteria from Then statements
    acceptance_criteria = []
    for line in lines:
        if "Then " in line or "And " in line:
            criterion = line.strip()
            if criterion.startswith("Then"):
                criterion = criterion[4:].strip()
            elif criterion.startswith("And"):
                criterion = criterion[3:].strip()
            acceptance_criteria.append(criterion)

    return FeatureTask(
        task_id=f"{category}/{task_id}",
        category=category,
        complexity=complexity,
        scenario_name=feature_name,
        context=context.strip(),
        acceptance_criteria=acceptance_criteria
    )


def discover_feature_files() -> List[Path]:
    """Find all .feature files in the features directory."""
    features_dir = Path("features")
    return list(features_dir.rglob("*.feature"))


# Result recording
@dataclass
class RunRecord:
    """Record of an agent run for training data."""
    task_id: str
    strategy: str
    complexity: str
    category: str
    prompt_tokens_raw: int
    prompt_tokens_compressed: int
    completion_tokens: int
    total_cost_usd: float
    turn_count: int
    tool_call_count: int
    quality_score: float
    passed_criteria: bool
    timestamp: str

    def to_jsonl(self) -> str:
        return json.dumps(asdict(self), separators=(',', ':'))


def record_run(record: RunRecord) -> None:
    """Append a run record to the data/runs directory."""
    runs_dir = Path("data/runs")
    runs_dir.mkdir(parents=True, exist_ok=True)

    # Write to dated file
    date_str = datetime.now(timezone.utc).strftime("%Y-%m-%d")
    runs_file = runs_dir / f"{date_str}.jsonl"

    with open(runs_file, "a") as f:
        f.write(record.to_jsonl() + "\n")


# Strategy definitions
STRATEGIES = [
    "single-haiku",
    "single-sonnet",
    "single-opus",
    "advisor",
    "cascade",
    "parallel-vote",
    "compressed-sonnet",
    "compressed-advisor",
    "speculative",
]

__all__ = ["parse_feature_file", "discover_feature_files", "RunRecord", "record_run", "STRATEGIES"]