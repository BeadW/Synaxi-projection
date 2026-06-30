Feature: HumanEval/107 — implement even_odd_palindrome
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def even_odd_palindrome(n):
          '''
          Given a positive integer n, return a tuple that has the number of even and odd
          integer palindromes that fall within the range(1, n), inclusive.

          Example 1:

              Input: 3
              Output: (1, 2)
              Explanation:
              Integer palindrome are 1, 2, 3. one of them is even, and two of them are odd.

          Example 2:

              Input: 12
              Output: (4, 6)
              Explanation:
              Integer palindrome are 1, 2, 3, 4, 5, 6, 7, 8, 9, 11. four of them are even, and 6 of them are odd.

          Note:
              1. 1 <= n <= 10^3
              2. returned tuple has the number of even and odd integer palindromes respectively.
          '''
          pass

      === test_solution.py ===
      from solution import even_odd_palindrome


      def test_humaneval():

          # Check some simple cases
          assert even_odd_palindrome(123) == (8, 13)
          assert even_odd_palindrome(12) == (4, 6)
          assert even_odd_palindrome(3) == (1, 2)
          assert even_odd_palindrome(63) == (6, 8)
          assert even_odd_palindrome(25) == (5, 6)
          assert even_odd_palindrome(19) == (4, 6)
          assert even_odd_palindrome(9) == (4, 5), "This prints if this assert fails 1 (good for debugging!)"

          # Check some edge cases that are easy to work out by hand.
          assert even_odd_palindrome(1) == (0, 1), "This prints if this assert fails 2 (also good for debugging!)"


      """

  Scenario: Agent implements even_odd_palindrome so all tests pass
    Given an agent is tasked with implementing the even_odd_palindrome function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
