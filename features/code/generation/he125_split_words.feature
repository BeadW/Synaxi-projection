Feature: HumanEval/125 — implement split_words
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def split_words(txt):
          '''
          Given a string of words, return a list of words split on whitespace, if no whitespaces exists in the text you
          should split on commas ',' if no commas exists you should return the number of lower-case letters with odd order in the
          alphabet, ord('a') = 0, ord('b') = 1, ... ord('z') = 25
          Examples
          split_words("Hello world!") ➞ ["Hello", "world!"]
          split_words("Hello,world!") ➞ ["Hello", "world!"]
          split_words("abcdef") == 3 
          '''
          pass

      === test_solution.py ===
      from solution import split_words


      def test_humaneval():

          assert split_words("Hello world!") == ["Hello","world!"]
          assert split_words("Hello,world!") == ["Hello","world!"]
          assert split_words("Hello world,!") == ["Hello","world,!"]
          assert split_words("Hello,Hello,world !") == ["Hello,Hello,world","!"]
          assert split_words("abcdef") == 3
          assert split_words("aaabb") == 2
          assert split_words("aaaBb") == 1
          assert split_words("") == 0

      """

  Scenario: Agent implements split_words so all tests pass
    Given an agent is tasked with implementing the split_words function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
