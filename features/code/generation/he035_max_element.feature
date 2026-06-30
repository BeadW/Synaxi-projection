Feature: HumanEval/35 — implement max_element
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def max_element(l: list):
          '''Return maximum element in the list.
          >>> max_element([1, 2, 3])
          3
          >>> max_element([5, 3, -5, 2, -3, 3, 9, 0, 123, 1, -10])
          123
          '''
          pass

      === test_solution.py ===
      from solution import max_element


      def test_humaneval():
          assert max_element([1, 2, 3]) == 3
          assert max_element([5, 3, -5, 2, -3, 3, 9, 0, 124, 1, -10]) == 124

      """

  Scenario: Agent implements max_element so all tests pass
    Given an agent is tasked with implementing the max_element function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
