Feature: HumanEval/118 — implement get_closest_vowel
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def get_closest_vowel(word):
          '''You are given a word. Your task is to find the closest vowel that stands between 
          two consonants from the right side of the word (case sensitive).
    
          Vowels in the beginning and ending doesn't count. Return empty string if you didn't
          find any vowel met the above condition. 

          You may assume that the given string contains English letter only.

          Example:
          get_closest_vowel("yogurt") ==> "u"
          get_closest_vowel("FULL") ==> "U"
          get_closest_vowel("quick") ==> ""
          get_closest_vowel("ab") ==> ""
          '''
          pass

      === test_solution.py ===
      from solution import get_closest_vowel


      def test_humaneval():

          # Check some simple cases
          assert get_closest_vowel("yogurt") == "u"
          assert get_closest_vowel("full") == "u"
          assert get_closest_vowel("easy") == ""
          assert get_closest_vowel("eAsy") == ""
          assert get_closest_vowel("ali") == ""
          assert get_closest_vowel("bad") == "a"
          assert get_closest_vowel("most") == "o"
          assert get_closest_vowel("ab") == ""
          assert get_closest_vowel("ba") == ""
          assert get_closest_vowel("quick") == ""
          assert get_closest_vowel("anime") == "i"
          assert get_closest_vowel("Asia") == ""
          assert get_closest_vowel("Above") == "o"

          # Check some edge cases that are easy to work out by hand.
          assert True


      """

  Scenario: Agent implements get_closest_vowel so all tests pass
    Given an agent is tasked with implementing the get_closest_vowel function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
