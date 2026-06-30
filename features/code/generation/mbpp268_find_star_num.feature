Feature: MBPP/268 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def find_star_num(n):
          pass

      === test_solution.py ===
      from solution import find_star_num


      def test_mbpp():
          assert find_star_num(3) == 37
          assert find_star_num(4) == 73
          assert find_star_num(5) == 121

      """

  Scenario: Agent implements find_star_num so all pytest tests pass
    Given an agent is tasked with implementing the find_star_num function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
