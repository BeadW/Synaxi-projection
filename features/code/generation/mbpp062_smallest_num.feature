Feature: MBPP/62 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def smallest_num(xs):
          pass

      === test_solution.py ===
      from solution import smallest_num


      def test_mbpp():
          assert smallest_num([10, 20, 1, 45, 99]) == 1
          assert smallest_num([1, 2, 3]) == 1
          assert smallest_num([45, 46, 50, 60]) == 45

      """

  Scenario: Agent implements smallest_num so all pytest tests pass
    Given an agent is tasked with implementing the smallest_num function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
