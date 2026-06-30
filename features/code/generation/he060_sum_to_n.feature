Feature: HumanEval/60 — implement sum_to_n
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def sum_to_n(n: int):
          '''sum_to_n is a function that sums numbers from 1 to n.
          >>> sum_to_n(30)
          465
          >>> sum_to_n(100)
          5050
          >>> sum_to_n(5)
          15
          >>> sum_to_n(10)
          55
          >>> sum_to_n(1)
          1
          '''
          pass

      === test_solution.py ===
      from solution import sum_to_n


      def test_humaneval():
          assert sum_to_n(1) == 1
          assert sum_to_n(6) == 21
          assert sum_to_n(11) == 66
          assert sum_to_n(30) == 465
          assert sum_to_n(100) == 5050


      """

  Scenario: Agent implements sum_to_n so all tests pass
    Given an agent is tasked with implementing the sum_to_n function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
