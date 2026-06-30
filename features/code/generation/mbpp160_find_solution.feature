Feature: MBPP/160 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def find_solution(a, b, n):
          pass

      === test_solution.py ===
      from solution import find_solution


      def test_mbpp():
          assert find_solution(2, 3, 7) == (2, 1)
          assert find_solution(4, 2, 7) == None
          assert find_solution(1, 13, 17) == (4, 1)

      """

  Scenario: Agent implements find_solution so all pytest tests pass
    Given an agent is tasked with implementing the find_solution function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
