Feature: HumanEval/100 — implement make_a_pile
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def make_a_pile(n):
          '''
          Given a positive integer n, you have to make a pile of n levels of stones.
          The first level has n stones.
          The number of stones in the next level is:
              - the next odd number if n is odd.
              - the next even number if n is even.
          Return the number of stones in each level in a list, where element at index
          i represents the number of stones in the level (i+1).

          Examples:
          >>> make_a_pile(3)
          [3, 5, 7]
          '''
          pass

      === test_solution.py ===
      from solution import make_a_pile


      def test_humaneval():

          # Check some simple cases
          assert make_a_pile(3) == [3, 5, 7], "Test 3"
          assert make_a_pile(4) == [4,6,8,10], "Test 4"
          assert make_a_pile(5) == [5, 7, 9, 11, 13]
          assert make_a_pile(6) == [6, 8, 10, 12, 14, 16]
          assert make_a_pile(8) == [8, 10, 12, 14, 16, 18, 20, 22]

          # Check some edge cases that are easy to work out by hand.
          assert True, "This prints if this assert fails 2 (also good for debugging!)"


      """

  Scenario: Agent implements make_a_pile so all tests pass
    Given an agent is tasked with implementing the make_a_pile function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
