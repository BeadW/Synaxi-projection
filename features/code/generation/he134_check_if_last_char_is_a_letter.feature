Feature: HumanEval/134 — implement check_if_last_char_is_a_letter
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def check_if_last_char_is_a_letter(txt):
          '''
          Create a function that returns True if the last character
          of a given string is an alphabetical character and is not
          a part of a word, and False otherwise.
          Note: "word" is a group of characters separated by space.

          Examples:
          check_if_last_char_is_a_letter("apple pie") ➞ False
          check_if_last_char_is_a_letter("apple pi e") ➞ True
          check_if_last_char_is_a_letter("apple pi e ") ➞ False
          check_if_last_char_is_a_letter("") ➞ False 
          '''
          pass

      === test_solution.py ===
      from solution import check_if_last_char_is_a_letter


      def test_humaneval():

          # Check some simple cases
          assert check_if_last_char_is_a_letter("apple") == False
          assert check_if_last_char_is_a_letter("apple pi e") == True
          assert check_if_last_char_is_a_letter("eeeee") == False
          assert check_if_last_char_is_a_letter("A") == True
          assert check_if_last_char_is_a_letter("Pumpkin pie ") == False
          assert check_if_last_char_is_a_letter("Pumpkin pie 1") == False
          assert check_if_last_char_is_a_letter("") == False
          assert check_if_last_char_is_a_letter("eeeee e ") == False
          assert check_if_last_char_is_a_letter("apple pie") == False
          assert check_if_last_char_is_a_letter("apple pi e ") == False

          # Check some edge cases that are easy to work out by hand.
          assert True


      """

  Scenario: Agent implements check_if_last_char_is_a_letter so all tests pass
    Given an agent is tasked with implementing the check_if_last_char_is_a_letter function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
