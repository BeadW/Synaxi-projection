Feature: HumanEval/149 — implement sorted_list_sum
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def sorted_list_sum(lst):
          '''Write a function that accepts a list of strings as a parameter,
          deletes the strings that have odd lengths from it,
          and returns the resulted list with a sorted order,
          The list is always a list of strings and never an array of numbers,
          and it may contain duplicates.
          The order of the list should be ascending by length of each word, and you
          should return the list sorted by that rule.
          If two words have the same length, sort the list alphabetically.
          The function should return a list of strings in sorted order.
          You may assume that all words will have the same length.
          For example:
          assert list_sort(["aa", "a", "aaa"]) => ["aa"]
          assert list_sort(["ab", "a", "aaa", "cd"]) => ["ab", "cd"]
          '''
          pass

      === test_solution.py ===
      from solution import sorted_list_sum


      def test_humaneval():

          # Check some simple cases
          assert sorted_list_sum(["aa", "a", "aaa"]) == ["aa"]
          assert sorted_list_sum(["school", "AI", "asdf", "b"]) == ["AI", "asdf", "school"]
          assert sorted_list_sum(["d", "b", "c", "a"]) == []
          assert sorted_list_sum(["d", "dcba", "abcd", "a"]) == ["abcd", "dcba"]

          # Check some edge cases that are easy to work out by hand.
          assert sorted_list_sum(["AI", "ai", "au"]) == ["AI", "ai", "au"]
          assert sorted_list_sum(["a", "b", "b", "c", "c", "a"]) == []
          assert sorted_list_sum(['aaaa', 'bbbb', 'dd', 'cc']) == ["cc", "dd", "aaaa", "bbbb"]


      """

  Scenario: Agent implements sorted_list_sum so all tests pass
    Given an agent is tasked with implementing the sorted_list_sum function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
