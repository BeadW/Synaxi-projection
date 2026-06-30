Feature: HumanEval/34 — implement unique
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def unique(l: list):
          '''Return sorted unique elements in a list
          >>> unique([5, 3, 5, 2, 3, 3, 9, 0, 123])
          [0, 2, 3, 5, 9, 123]
          '''
          pass

      === test_solution.py ===
      from solution import unique


      def test_humaneval():
          assert unique([5, 3, 5, 2, 3, 3, 9, 0, 123]) == [0, 2, 3, 5, 9, 123]


      """

  Scenario: Agent implements unique so all tests pass
    Given an agent is tasked with implementing the unique function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
