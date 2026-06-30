Feature: MBPP/290 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def max_length(list1):
          pass

      === test_solution.py ===
      from solution import max_length


      def test_mbpp():
          assert max_length([[0], [1, 3], [5, 7], [9, 11], [13, 15, 17]])==(3, [13, 15, 17])
          assert max_length([[1], [5, 7], [10, 12, 14,15]])==(4, [10, 12, 14,15])
          assert max_length([[5], [15,20,25]])==(3, [15,20,25])

      """

  Scenario: Agent implements max_length so all pytest tests pass
    Given an agent is tasked with implementing the max_length function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
