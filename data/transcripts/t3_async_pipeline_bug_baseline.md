# BASELINE — t3_async_pipeline_bug
Model: haiku  Task: making all pytest tests pass

---
## Turn 1
**Context size:** 102 chars  (1 messages)

**Model text:**
I'll help you make all pytest tests pass. Let me start by exploring the sandbox directory to see what we're working with.

**Tool:** `run_command({"command": "find . -type f -name \"*.py\" | head -20"})`

**Result:** `exit=0
./pipeline.py
./test_pipeline.py
`

## Turn 2
**Context size:** 633 chars  (3 messages)

**Model text:**
Let me check the test file to see what tests need to pass:

**Tool:** `read_file({"path": "./test_pipeline.py"})`

**Result:** `import asyncio
import pytest
from pipeline import AsyncPipeline

@pytest.mark.asyncio
async def test_basic_pipeline():
    p = AsyncPipeline()
    p.add_stage(lambda x: x * 2)
    p.add_stage(lambda x`

**Tool:** `read_file({"path": "./pipeline.py"})`

**Result:** `import asyncio
from typing import List, Callable, Any

class AsyncPipeline:
    def __init__(self):
        self.stages: List[Callable] = []

    def add_stage(self, fn: Callable) -> "AsyncPipeline":
`

## Turn 3
**Context size:** 2978 chars  (5 messages)

**Model text:**
Now let me run the tests to see what's failing:

**Tool:** `run_command({"command": "cd /sandbox && pytest test_pipeline.py -v"})`

**Result:** `exit=1
/bin/sh: line 0: cd: /sandbox: No such file or directory
`

## Turn 4
**Context size:** 3459 chars  (7 messages)

**Tool:** `run_command({"command": "pwd && pytest test_pipeline.py -v"})`

**Result:** `exit=1
/private/var/folders/0t/72yqwvrd5xz3bvh3pb75l8hr0000gn/T/synaxi_task_1g2lqimi
============================= test session starts ==============================
platform darwin -- Python 3.9.6, p`

## Turn 5
**Context size:** 5839 chars  (9 messages)

**Model text:**
I can see the issue! In the `_process` method, when we have an async function, we're calling it but not awaiting it. Let me fix the `pipeline.py` file:

**Tool:** `write_file({"path": "./pipeline.py", "content": "import asyncio\nfrom typing import List, C)`

**Result:** `Written 953 bytes to ./pipeline.py`

## Turn 6
**Context size:** 7362 chars  (11 messages)

**Model text:**
Now let's run the tests again to verify they all pass:

**Tool:** `run_command({"command": "pytest test_pipeline.py -v"})`

**Result:** `exit=0
============================= test session starts ==============================
platform darwin -- Python 3.9.6, pytest-7.4.4, pluggy-1.6.0 -- /Applications/Xcode.app/Contents/Developer/usr/bi`

## Turn 7
**Context size:** 8532 chars  (13 messages)

**Model text:**
Perfect! ✅ All pytest tests are now passing! 

## Summary

The issue was in the `_process` method of the `AsyncPipeline` class. When a stage function was asynchronous (detected via `asyncio.iscoroutinefunction()`), the code was calling the function but not **awaiting** it.

**The fix:** Changed line from:
```python
value = stage(value)
```
to:
```python
value = await stage(value)
```

This ensures that asynchronous functions are properly awaited, returning their actual results rather than unawaited coroutine objects. Now all three tests pass:
- ✅ `test_basic_pipeline` - Tests synchronous pipeline stages
- ✅ `test_async_stages` - Tests asynchronous pipeline stages with parallel execution
- ✅ `test_empty_input` - Tests handling of empty input lists


---
## Result: PASS ✅

```
...                                                                      [100%]
3 passed in 0.00s

```

Input tokens: 12899  Output: 1006  Tools: 7
