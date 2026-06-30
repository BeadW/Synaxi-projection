Feature: HumanEval/84 — implement solve
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def solve(N):
          '''Given a positive integer N, return the total sum of its digits in binary.
    
          Example
              For N = 1000, the sum of digits will be 1 the output should be "1".
              For N = 150, the sum of digits will be 6 the output should be "110".
              For N = 147, the sum of digits will be 12 the output should be "1100".
    
          Variables:
              @N integer
                   Constraints: 0 ≤ N ≤ 10000.
          Output:
               a string of binary number
          '''
          pass

      === test_solution.py ===
      from solution import solve


      def test_humaneval():

          # Check some simple cases
          assert True, "This prints if this assert fails 1 (good for debugging!)"
          assert solve(1000) == "1", "Error"
          assert solve(150) == "110", "Error"
          assert solve(147) == "1100", "Error"

          # Check some edge cases that are easy to work out by hand.
          assert True, "This prints if this assert fails 2 (also good for debugging!)"
          assert solve(333) == "1001", "Error"
          assert solve(963) == "10010", "Error"


      """

  Scenario: Agent implements solve so all tests pass
    Given an agent is tasked with implementing the solve function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
