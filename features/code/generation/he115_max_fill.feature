Feature: HumanEval/115 — implement max_fill
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def max_fill(grid, capacity):
          import math
          '''
          You are given a rectangular grid of wells. Each row represents a single well,
          and each 1 in a row represents a single unit of water.
          Each well has a corresponding bucket that can be used to extract water from it, 
          and all buckets have the same capacity.
          Your task is to use the buckets to empty the wells.
          Output the number of times you need to lower the buckets.

          Example 1:
              Input: 
                  grid : [[0,0,1,0], [0,1,0,0], [1,1,1,1]]
                  bucket_capacity : 1
              Output: 6

          Example 2:
              Input: 
                  grid : [[0,0,1,1], [0,0,0,0], [1,1,1,1], [0,1,1,1]]
                  bucket_capacity : 2
              Output: 5
    
          Example 3:
              Input: 
                  grid : [[0,0,0], [0,0,0]]
                  bucket_capacity : 5
              Output: 0

          Constraints:
              * all wells have the same length
              * 1 <= grid.length <= 10^2
              * 1 <= grid[:,1].length <= 10^2
              * grid[i][j] -> 0 | 1
              * 1 <= capacity <= 10
          '''
          pass

      === test_solution.py ===
      from solution import max_fill


      def test_humaneval():


          # Check some simple cases
          assert True, "This prints if this assert fails 1 (good for debugging!)"
          assert max_fill([[0,0,1,0], [0,1,0,0], [1,1,1,1]], 1) == 6, "Error"
          assert max_fill([[0,0,1,1], [0,0,0,0], [1,1,1,1], [0,1,1,1]], 2) == 5, "Error"
          assert max_fill([[0,0,0], [0,0,0]], 5) == 0, "Error"

          # Check some edge cases that are easy to work out by hand.
          assert True, "This prints if this assert fails 2 (also good for debugging!)"
          assert max_fill([[1,1,1,1], [1,1,1,1]], 2) == 4, "Error"
          assert max_fill([[1,1,1,1], [1,1,1,1]], 9) == 2, "Error"


      """

  Scenario: Agent implements max_fill so all tests pass
    Given an agent is tasked with implementing the max_fill function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
