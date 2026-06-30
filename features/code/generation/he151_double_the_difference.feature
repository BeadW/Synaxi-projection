Feature: HumanEval/151 — implement double_the_difference
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def double_the_difference(lst):
          '''
          Given a list of numbers, return the sum of squares of the numbers
          in the list that are odd. Ignore numbers that are negative or not integers.
    
          double_the_difference([1, 3, 2, 0]) == 1 + 9 + 0 + 0 = 10
          double_the_difference([-1, -2, 0]) == 0
          double_the_difference([9, -2]) == 81
          double_the_difference([0]) == 0  
   
          If the input list is empty, return 0.
          '''
          pass

      === test_solution.py ===
      from solution import double_the_difference


      def test_humaneval():

          # Check some simple cases
          assert double_the_difference([]) == 0 , "This prints if this assert fails 1 (good for debugging!)"
          assert double_the_difference([5, 4]) == 25 , "This prints if this assert fails 2 (good for debugging!)"
          assert double_the_difference([0.1, 0.2, 0.3]) == 0 , "This prints if this assert fails 3 (good for debugging!)"
          assert double_the_difference([-10, -20, -30]) == 0 , "This prints if this assert fails 4 (good for debugging!)"


          # Check some edge cases that are easy to work out by hand.
          assert double_the_difference([-1, -2, 8]) == 0, "This prints if this assert fails 5 (also good for debugging!)"
          assert double_the_difference([0.2, 3, 5]) == 34, "This prints if this assert fails 6 (also good for debugging!)"
          lst = list(range(-99, 100, 2))
          odd_sum = sum([i**2 for i in lst if i%2!=0 and i > 0])
          assert double_the_difference(lst) == odd_sum , "This prints if this assert fails 7 (good for debugging!)"


      """

  Scenario: Agent implements double_the_difference so all tests pass
    Given an agent is tasked with implementing the double_the_difference function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
