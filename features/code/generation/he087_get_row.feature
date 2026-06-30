Feature: HumanEval/87 — implement get_row
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def get_row(lst, x):
          '''
          You are given a 2 dimensional data, as a nested lists,
          which is similar to matrix, however, unlike matrices,
          each row may contain a different number of columns.
          Given lst, and integer x, find integers x in the list,
          and return list of tuples, [(x1, y1), (x2, y2) ...] such that
          each tuple is a coordinate - (row, columns), starting with 0.
          Sort coordinates initially by rows in ascending order.
          Also, sort coordinates of the row by columns in descending order.
    
          Examples:
          get_row([
            [1,2,3,4,5,6],
            [1,2,3,4,1,6],
            [1,2,3,4,5,1]
          ], 1) == [(0, 0), (1, 4), (1, 0), (2, 5), (2, 0)]
          get_row([], 1) == []
          get_row([[], [1], [1, 2, 3]], 3) == [(2, 2)]
          '''
          pass

      === test_solution.py ===
      from solution import get_row


      def test_humaneval():

          # Check some simple cases
          assert get_row([
              [1,2,3,4,5,6],
              [1,2,3,4,1,6],
              [1,2,3,4,5,1]
          ], 1) == [(0, 0), (1, 4), (1, 0), (2, 5), (2, 0)]
          assert get_row([
              [1,2,3,4,5,6],
              [1,2,3,4,5,6],
              [1,2,3,4,5,6],
              [1,2,3,4,5,6],
              [1,2,3,4,5,6],
              [1,2,3,4,5,6]
          ], 2) == [(0, 1), (1, 1), (2, 1), (3, 1), (4, 1), (5, 1)]
          assert get_row([
              [1,2,3,4,5,6],
              [1,2,3,4,5,6],
              [1,1,3,4,5,6],
              [1,2,1,4,5,6],
              [1,2,3,1,5,6],
              [1,2,3,4,1,6],
              [1,2,3,4,5,1]
          ], 1) == [(0, 0), (1, 0), (2, 1), (2, 0), (3, 2), (3, 0), (4, 3), (4, 0), (5, 4), (5, 0), (6, 5), (6, 0)]
          assert get_row([], 1) == []
          assert get_row([[1]], 2) == []
          assert get_row([[], [1], [1, 2, 3]], 3) == [(2, 2)]

          # Check some edge cases that are easy to work out by hand.
          assert True


      """

  Scenario: Agent implements get_row so all tests pass
    Given an agent is tasked with implementing the get_row function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
