Feature: HumanEval/52 — implement below_threshold
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def below_threshold(l: list, t: int):
          '''Return True if all numbers in the list l are below threshold t.
          >>> below_threshold([1, 2, 4, 10], 100)
          True
          >>> below_threshold([1, 20, 4, 10], 5)
          False
          '''
          pass

      === test_solution.py ===
      from solution import below_threshold


      def test_humaneval():
          assert below_threshold([1, 2, 4, 10], 100)
          assert not below_threshold([1, 20, 4, 10], 5)
          assert below_threshold([1, 20, 4, 10], 21)
          assert below_threshold([1, 20, 4, 10], 22)
          assert below_threshold([1, 8, 4, 10], 11)
          assert not below_threshold([1, 8, 4, 10], 10)


      """

  Scenario: Agent implements below_threshold so all tests pass
    Given an agent is tasked with implementing the below_threshold function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
