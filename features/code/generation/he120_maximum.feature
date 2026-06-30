Feature: HumanEval/120 — implement maximum
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def maximum(arr, k):
          '''
          Given an array arr of integers and a positive integer k, return a sorted list 
          of length k with the maximum k numbers in arr.

          Example 1:

              Input: arr = [-3, -4, 5], k = 3
              Output: [-4, -3, 5]

          Example 2:

              Input: arr = [4, -4, 4], k = 2
              Output: [4, 4]

          Example 3:

              Input: arr = [-3, 2, 1, 2, -1, -2, 1], k = 1
              Output: [2]

          Note:
              1. The length of the array will be in the range of [1, 1000].
              2. The elements in the array will be in the range of [-1000, 1000].
              3. 0 <= k <= len(arr)
          '''
          pass

      === test_solution.py ===
      from solution import maximum


      def test_humaneval():

          # Check some simple cases
          assert maximum([-3, -4, 5], 3) == [-4, -3, 5]
          assert maximum([4, -4, 4], 2) == [4, 4]
          assert maximum([-3, 2, 1, 2, -1, -2, 1], 1) == [2]
          assert maximum([123, -123, 20, 0 , 1, 2, -3], 3) == [2, 20, 123]
          assert maximum([-123, 20, 0 , 1, 2, -3], 4) == [0, 1, 2, 20]
          assert maximum([5, 15, 0, 3, -13, -8, 0], 7) == [-13, -8, 0, 0, 3, 5, 15]
          assert maximum([-1, 0, 2, 5, 3, -10], 2) == [3, 5]
          assert maximum([1, 0, 5, -7], 1) == [5]
          assert maximum([4, -4], 2) == [-4, 4]
          assert maximum([-10, 10], 2) == [-10, 10]

          # Check some edge cases that are easy to work out by hand.
          assert maximum([1, 2, 3, -23, 243, -400, 0], 0) == []


      """

  Scenario: Agent implements maximum so all tests pass
    Given an agent is tasked with implementing the maximum function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
