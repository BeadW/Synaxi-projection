Feature: HumanEval/143 — implement words_in_sentence
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def words_in_sentence(sentence):
          '''
          You are given a string representing a sentence,
          the sentence contains some words separated by a space,
          and you have to return a string that contains the words from the original sentence,
          whose lengths are prime numbers,
          the order of the words in the new string should be the same as the original one.

          Example 1:
              Input: sentence = "This is a test"
              Output: "is"

          Example 2:
              Input: sentence = "lets go for swimming"
              Output: "go for"

          Constraints:
              * 1 <= len(sentence) <= 100
              * sentence contains only letters
          '''
          pass

      === test_solution.py ===
      from solution import words_in_sentence


      def test_humaneval():

          # Check some simple cases
          assert words_in_sentence("This is a test") == "is"
          assert words_in_sentence("lets go for swimming") == "go for"
          assert words_in_sentence("there is no place available here") == "there is no place"
          assert words_in_sentence("Hi I am Hussein") == "Hi am Hussein"
          assert words_in_sentence("go for it") == "go for it"

          # Check some edge cases that are easy to work out by hand.
          assert words_in_sentence("here") == ""
          assert words_in_sentence("here is") == "is"


      """

  Scenario: Agent implements words_in_sentence so all tests pass
    Given an agent is tasked with implementing the words_in_sentence function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
