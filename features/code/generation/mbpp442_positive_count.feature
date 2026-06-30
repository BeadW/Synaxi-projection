Feature: MBPP/442 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def positive_count():
          pass

      === test_solution.py ===
      from solution import positive_count


      def test_mbpp():
          assert positive_count([0, 1, 2, -1, -5, 6, 0, -3, -2, 3, 4, 6, 8])==0.54
          assert positive_count([2, 1, 2, -1, -5, 6, 4, -3, -2, 3, 4, 6, 8])==0.69
          assert positive_count([2, 4, -6, -9, 11, -12, 14, -5, 17])==0.56

      """

  Scenario: Agent implements positive_count so all pytest tests pass
    Given an agent is tasked with implementing the positive_count function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
