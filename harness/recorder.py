import json
import time
from pathlib import Path

PROJECT_ROOT = Path(__file__).parent.parent
RUNS_DIR = PROJECT_ROOT / "data" / "runs"


def record(run: dict) -> None:
    RUNS_DIR.mkdir(parents=True, exist_ok=True)
    slug = run.get("task_id", "unknown").replace("/", "_").replace(" ", "_")
    path = RUNS_DIR / f"{slug}_{int(time.time())}.jsonl"
    with open(path, "a") as f:
        f.write(json.dumps(run) + "\n")
