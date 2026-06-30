Feature: HumanEval/74 — implement total_match
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def total_match(lst1, lst2):
          '''
          Write a function that accepts two lists of strings and returns the list that has 
          total number of chars in the all strings of the list less than the other list.

          if the two lists have the same number of chars, return the first list.

          Examples
          total_match([], []) ➞ []
          total_match(['hi', 'admin'], ['hI', 'Hi']) ➞ ['hI', 'Hi']
          total_match(['hi', 'admin'], ['hi', 'hi', 'admin', 'project']) ➞ ['hi', 'admin']
          total_match(['hi', 'admin'], ['hI', 'hi', 'hi']) ➞ ['hI', 'hi', 'hi']
          total_match(['4'], ['1', '2', '3', '4', '5']) ➞ ['4']
          '''
          pass

      === test_solution.py ===
      from solution import total_match


      def test_humaneval():

          # Check some simple cases
          assert True, "This prints if this assert fails 1 (good for debugging!)"
          assert total_match([], []) == []
          assert total_match(['hi', 'admin'], ['hi', 'hi']) == ['hi', 'hi']
          assert total_match(['hi', 'admin'], ['hi', 'hi', 'admin', 'project']) == ['hi', 'admin']
          assert total_match(['4'], ['1', '2', '3', '4', '5']) == ['4']
          assert total_match(['hi', 'admin'], ['hI', 'Hi']) == ['hI', 'Hi']
          assert total_match(['hi', 'admin'], ['hI', 'hi', 'hi']) == ['hI', 'hi', 'hi']
          assert total_match(['hi', 'admin'], ['hI', 'hi', 'hii']) == ['hi', 'admin']


          # Check some edge cases that are easy to work out by hand.
          assert True, "This prints if this assert fails 2 (also good for debugging!)"
          assert total_match([], ['this']) == []
          assert total_match(['this'], []) == []


      """

  Scenario: Agent implements total_match so all tests pass
    Given an agent is tasked with implementing the total_match function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
