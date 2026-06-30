Feature: HumanEval/53 — implement add
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def add(x: int, y: int):
          '''Add two numbers x and y
          >>> add(2, 3)
          5
          >>> add(5, 7)
          12
          '''
          pass

      === test_solution.py ===
      from solution import add


      def test_humaneval():
          import random

          assert add(0, 1) == 1
          assert add(1, 0) == 1
          assert add(2, 3) == 5
          assert add(5, 7) == 12
          assert add(7, 5) == 12

          for i in range(100):
              x, y = random.randint(0, 1000), random.randint(0, 1000)
              assert add(x, y) == x + y


      """

  Scenario: Agent implements add so all tests pass
    Given an agent is tasked with implementing the add function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
