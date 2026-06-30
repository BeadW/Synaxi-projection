Feature: Debug an async data pipeline with multiple subtle bugs
  Complexity: T3
  Category: code/debug
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === pipeline.py ===
      import asyncio
      from typing import List, Callable, Any

      class AsyncPipeline:
          def __init__(self):
              self.stages: List[Callable] = []

          def add_stage(self, fn: Callable) -> "AsyncPipeline":
              self.stages.append(fn)
              return self

          async def run(self, items: List[Any]) -> List[Any]:
              results = []
              for item in items:
                  value = item
                  for stage in self.stages:
                      value = stage(value)
                  results.append(value)
              return results

          async def run_parallel(self, items: List[Any]) -> List[Any]:
              tasks = [self._process(item) for item in items]
              return await asyncio.gather(*tasks)

          async def _process(self, item: Any) -> Any:
              value = item
              for stage in self.stages:
                  if asyncio.iscoroutinefunction(stage):
                      value = stage(value)
                  else:
                      value = stage(value)
              return value

      === test_pipeline.py ===
      import asyncio
      import pytest
      from pipeline import AsyncPipeline

      @pytest.mark.asyncio
      async def test_basic_pipeline():
          p = AsyncPipeline()
          p.add_stage(lambda x: x * 2)
          p.add_stage(lambda x: x + 1)
          result = await p.run([1, 2, 3])
          assert result == [3, 5, 7]

      @pytest.mark.asyncio
      async def test_async_stages():
          async def double(x):
              await asyncio.sleep(0)
              return x * 2

          p = AsyncPipeline()
          p.add_stage(double)
          result = await p.run_parallel([1, 2, 3])
          assert result == [2, 4, 6]

      @pytest.mark.asyncio
      async def test_empty_input():
          p = AsyncPipeline()
          p.add_stage(lambda x: x + 1)
          result = await p.run([])
          assert result == []
      """

  Scenario: Agent fixes all bugs so pytest passes
    Given an agent is tasked with making all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
