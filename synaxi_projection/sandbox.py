"""
Sandbox utilities: isolated temp directories for multi-turn agent tasks,
plus lightweight code execution helpers for single-turn evaluation.
"""

import ast
import os
import re
import shutil
import subprocess
import sys
import tempfile
from contextlib import contextmanager
from pathlib import Path
from typing import Dict, Optional


# --------------------------------------------------------------------------- #
# Multi-turn: file-based task sandbox
# --------------------------------------------------------------------------- #

class TaskSandbox:
    """
    Temporary working directory pre-populated with fixture files.

    Usage
    -----
    with TaskSandbox({"calculator.py": "def add(a,b): return a-b"}) as sb:
        result = run_task("Fix the bug in calculator.py", cwd=sb.path)
        sb.run_pytest()  # verify
    """

    def __init__(self, files: Dict[str, str]):
        self._files = files
        self._tmpdir: Optional[tempfile.TemporaryDirectory] = None
        self.path: Optional[str] = None

    def __enter__(self) -> "TaskSandbox":
        self._tmpdir = tempfile.TemporaryDirectory(prefix="synaxi_task_")
        self.path = self._tmpdir.name
        for filename, content in self._files.items():
            dest = Path(self.path) / filename
            dest.parent.mkdir(parents=True, exist_ok=True)
            dest.write_text(content)
        return self

    def __exit__(self, *_):
        if self._tmpdir:
            self._tmpdir.cleanup()

    def read(self, filename: str) -> str:
        return (Path(self.path) / filename).read_text()

    def run_pytest(self, timeout: int = 30) -> tuple[bool, str]:
        """Run pytest in the sandbox. Returns (passed, output)."""
        result = subprocess.run(
            [sys.executable, "-m", "pytest", "-x", "--tb=short", "-q"],
            capture_output=True, text=True, timeout=timeout, cwd=self.path,
        )
        output = result.stdout + result.stderr
        return result.returncode == 0, output

    def run_script(self, script: str, timeout: int = 15) -> tuple[bool, str]:
        """Run an inline test script against files in the sandbox."""
        # Read all .py files so the test script can import them
        imports = ""
        for py_file in Path(self.path).glob("*.py"):
            if not py_file.name.startswith("test_"):
                src = py_file.read_text()
                imports += src + "\n\n"
        full = imports + script
        with tempfile.NamedTemporaryFile(
            mode="w", suffix=".py", delete=False, dir=self.path
        ) as f:
            f.write(full)
            path = f.name
        try:
            result = subprocess.run(
                [sys.executable, path],
                capture_output=True, text=True, timeout=timeout, cwd=self.path,
            )
            return result.returncode == 0, result.stderr.strip()
        finally:
            os.unlink(path)


@contextmanager
def task_sandbox(files: Dict[str, str]):
    """Convenience context manager — yields a TaskSandbox."""
    with TaskSandbox(files) as sb:
        yield sb


# --------------------------------------------------------------------------- #
# Single-turn: inline code execution helpers
# --------------------------------------------------------------------------- #

def extract_python_code(response: str) -> str:
    match = re.search(r"```(?:python)?\n(.*?)```", response, re.DOTALL)
    if match:
        return match.group(1).strip()
    return response.strip()


def run_call(code: str, func_call: str, timeout: int = 10):
    script = f"{code}\n\n_result = {func_call}\nprint(repr(_result))"
    output = _run_inline(script, timeout)
    return ast.literal_eval(output.strip())


def run_script(code: str, test_script: str, timeout: int = 10) -> None:
    _run_inline(f"{code}\n\n{test_script}", timeout)


def _run_inline(script: str, timeout: int) -> str:
    with tempfile.NamedTemporaryFile(mode="w", suffix=".py", delete=False) as f:
        f.write(script)
        path = f.name
    try:
        result = subprocess.run(
            [sys.executable, path],
            capture_output=True, text=True, timeout=timeout,
        )
        if result.returncode != 0:
            raise AssertionError(
                f"Execution failed (exit {result.returncode}):\n{result.stderr.strip()}"
            )
        return result.stdout
    finally:
        os.unlink(path)
