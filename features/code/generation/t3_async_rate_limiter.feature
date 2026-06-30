Feature: Generate an async rate limiter
  Complexity: T3
  Category: code/generation

  Scenario: Agent writes a token bucket rate limiter for async code
    Given an agent is tasked with writing a Python class called RateLimiter using asyncio that allows at most N calls per second using a token bucket algorithm, with an async acquire() method that waits until a token is available
    When the agent completes the task
    Then the code execution script passes:
      """
      import asyncio
      import time

      async def test():
          limiter = RateLimiter(rate=5)
          times = []
          async def job():
              await limiter.acquire()
              times.append(time.monotonic())
          await asyncio.gather(*[job() for _ in range(10)])
          gaps = [times[i+1] - times[i] for i in range(len(times)-1)]
          slow_gaps = [g for g in gaps if g > 0.15]
          assert len(slow_gaps) >= 4, f"Expected at least 4 throttled gaps, got {len(slow_gaps)}"

      asyncio.run(test())
      """
