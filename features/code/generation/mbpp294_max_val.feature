Feature: MBPP/294 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def max_val(listval):
          pass

      === test_solution.py ===
      from solution import max_val


      def test_mbpp():
          assert max_val(['Python', 3, 2, 4, 5, 'version'])==5
          assert max_val(['Python', 15, 20, 25])==25
          assert max_val(['Python', 30, 20, 40, 50, 'version'])==50

      """

  Scenario: Agent implements max_val so all pytest tests pass
    Given an agent is tasked with implementing the max_val function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
