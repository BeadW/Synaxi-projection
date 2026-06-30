Feature: HumanEval/101 — implement words_string
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def words_string(s):
          '''
          You will be given a string of words separated by commas or spaces. Your task is
          to split the string into words and return an array of the words.
    
          For example:
          words_string("Hi, my name is John") == ["Hi", "my", "name", "is", "John"]
          words_string("One, two, three, four, five, six") == ["One", "two", "three", "four", "five", "six"]
          '''
          pass

      === test_solution.py ===
      from solution import words_string


      def test_humaneval():

          # Check some simple cases
          assert True, "This prints if this assert fails 1 (good for debugging!)"
          assert words_string("Hi, my name is John") == ["Hi", "my", "name", "is", "John"]
          assert words_string("One, two, three, four, five, six") == ["One", "two", "three", "four", "five", "six"]
          assert words_string("Hi, my name") == ["Hi", "my", "name"]
          assert words_string("One,, two, three, four, five, six,") == ["One", "two", "three", "four", "five", "six"]

          # Check some edge cases that are easy to work out by hand.
          assert True, "This prints if this assert fails 2 (also good for debugging!)"
          assert words_string("") == []
          assert words_string("ahmed     , gamal") == ["ahmed", "gamal"]


      """

  Scenario: Agent implements words_string so all tests pass
    Given an agent is tasked with implementing the words_string function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
