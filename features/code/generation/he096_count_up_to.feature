Feature: HumanEval/96 — implement count_up_to
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def count_up_to(n):
          '''Implement a function that takes an non-negative integer and returns an array of the first n
          integers that are prime numbers and less than n.
          for example:
          count_up_to(5) => [2,3]
          count_up_to(11) => [2,3,5,7]
          count_up_to(0) => []
          count_up_to(20) => [2,3,5,7,11,13,17,19]
          count_up_to(1) => []
          count_up_to(18) => [2,3,5,7,11,13,17]
          '''
          pass

      === test_solution.py ===
      from solution import count_up_to


      def test_humaneval():

          assert count_up_to(5) == [2,3]
          assert count_up_to(6) == [2,3,5]
          assert count_up_to(7) == [2,3,5]
          assert count_up_to(10) == [2,3,5,7]
          assert count_up_to(0) == []
          assert count_up_to(22) == [2,3,5,7,11,13,17,19]
          assert count_up_to(1) == []
          assert count_up_to(18) == [2,3,5,7,11,13,17]
          assert count_up_to(47) == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43]
          assert count_up_to(101) == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]


      """

  Scenario: Agent implements count_up_to so all tests pass
    Given an agent is tasked with implementing the count_up_to function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
