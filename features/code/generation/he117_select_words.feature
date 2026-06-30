Feature: HumanEval/117 — implement select_words
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def select_words(s, n):
          '''Given a string s and a natural number n, you have been tasked to implement 
          a function that returns a list of all words from string s that contain exactly 
          n consonants, in order these words appear in the string s.
          If the string s is empty then the function should return an empty list.
          Note: you may assume the input string contains only letters and spaces.
          Examples:
          select_words("Mary had a little lamb", 4) ==> ["little"]
          select_words("Mary had a little lamb", 3) ==> ["Mary", "lamb"]
          select_words("simple white space", 2) ==> []
          select_words("Hello world", 4) ==> ["world"]
          select_words("Uncle sam", 3) ==> ["Uncle"]
          '''
          pass

      === test_solution.py ===
      from solution import select_words


      def test_humaneval():

          # Check some simple cases
          assert select_words("Mary had a little lamb", 4) == ["little"], "First test error: " + str(select_words("Mary had a little lamb", 4))      
          assert select_words("Mary had a little lamb", 3) == ["Mary", "lamb"], "Second test error: " + str(select_words("Mary had a little lamb", 3))  
          assert select_words("simple white space", 2) == [], "Third test error: " + str(select_words("simple white space", 2))      
          assert select_words("Hello world", 4) == ["world"], "Fourth test error: " + str(select_words("Hello world", 4))  
          assert select_words("Uncle sam", 3) == ["Uncle"], "Fifth test error: " + str(select_words("Uncle sam", 3))


          # Check some edge cases that are easy to work out by hand.
          assert select_words("", 4) == [], "1st edge test error: " + str(select_words("", 4))
          assert select_words("a b c d e f", 1) == ["b", "c", "d", "f"], "2nd edge test error: " + str(select_words("a b c d e f", 1))


      """

  Scenario: Agent implements select_words so all tests pass
    Given an agent is tasked with implementing the select_words function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
