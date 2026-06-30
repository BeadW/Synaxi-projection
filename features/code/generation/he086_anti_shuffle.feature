Feature: HumanEval/86 — implement anti_shuffle
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def anti_shuffle(s):
          '''
          Write a function that takes a string and returns an ordered version of it.
          Ordered version of string, is a string where all words (separated by space)
          are replaced by a new word where all the characters arranged in
          ascending order based on ascii value.
          Note: You should keep the order of words and blank spaces in the sentence.

          For example:
          anti_shuffle('Hi') returns 'Hi'
          anti_shuffle('hello') returns 'ehllo'
          anti_shuffle('Hello World!!!') returns 'Hello !!!Wdlor'
          '''
          pass

      === test_solution.py ===
      from solution import anti_shuffle


      def test_humaneval():

          # Check some simple cases
          assert anti_shuffle('Hi') == 'Hi'
          assert anti_shuffle('hello') == 'ehllo'
          assert anti_shuffle('number') == 'bemnru'
          assert anti_shuffle('abcd') == 'abcd'
          assert anti_shuffle('Hello World!!!') == 'Hello !!!Wdlor'
          assert anti_shuffle('') == ''
          assert anti_shuffle('Hi. My name is Mister Robot. How are you?') == '.Hi My aemn is Meirst .Rboot How aer ?ouy'
          # Check some edge cases that are easy to work out by hand.
          assert True


      """

  Scenario: Agent implements anti_shuffle so all tests pass
    Given an agent is tasked with implementing the anti_shuffle function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
