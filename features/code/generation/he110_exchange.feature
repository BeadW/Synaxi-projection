Feature: HumanEval/110 — implement exchange
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def exchange(lst1, lst2):
          '''In this problem, you will implement a function that takes two lists of numbers,
          and determines whether it is possible to perform an exchange of elements
          between them to make lst1 a list of only even numbers.
          There is no limit on the number of exchanged elements between lst1 and lst2.
          If it is possible to exchange elements between the lst1 and lst2 to make
          all the elements of lst1 to be even, return "YES".
          Otherwise, return "NO".
          For example:
          exchange([1, 2, 3, 4], [1, 2, 3, 4]) => "YES"
          exchange([1, 2, 3, 4], [1, 5, 3, 4]) => "NO"
          It is assumed that the input lists will be non-empty.
          '''
          pass

      === test_solution.py ===
      from solution import exchange


      def test_humaneval():

          # Check some simple cases
          assert exchange([1, 2, 3, 4], [1, 2, 3, 4]) == "YES"
          assert exchange([1, 2, 3, 4], [1, 5, 3, 4]) == "NO"
          assert exchange([1, 2, 3, 4], [2, 1, 4, 3]) == "YES" 
          assert exchange([5, 7, 3], [2, 6, 4]) == "YES"
          assert exchange([5, 7, 3], [2, 6, 3]) == "NO" 
          assert exchange([3, 2, 6, 1, 8, 9], [3, 5, 5, 1, 1, 1]) == "NO"

          # Check some edge cases that are easy to work out by hand.
          assert exchange([100, 200], [200, 200]) == "YES"


      """

  Scenario: Agent implements exchange so all tests pass
    Given an agent is tasked with implementing the exchange function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
