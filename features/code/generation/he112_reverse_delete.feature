Feature: HumanEval/112 — implement reverse_delete
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def reverse_delete(s,c):
          '''Task
          We are given two strings s and c, you have to deleted all the characters in s that are equal to any character in c
          then check if the result string is palindrome.
          A string is called palindrome if it reads the same backward as forward.
          You should return a tuple containing the result string and True/False for the check.
          Example
          For s = "abcde", c = "ae", the result should be ('bcd',False)
          For s = "abcdef", c = "b"  the result should be ('acdef',False)
          For s = "abcdedcba", c = "ab", the result should be ('cdedc',True)
          '''
          pass

      === test_solution.py ===
      from solution import reverse_delete


      def test_humaneval():

          assert reverse_delete("abcde","ae") == ('bcd',False)
          assert reverse_delete("abcdef", "b") == ('acdef',False)
          assert reverse_delete("abcdedcba","ab") == ('cdedc',True)
          assert reverse_delete("dwik","w") == ('dik',False)
          assert reverse_delete("a","a") == ('',True)
          assert reverse_delete("abcdedcba","") == ('abcdedcba',True)
          assert reverse_delete("abcdedcba","v") == ('abcdedcba',True)
          assert reverse_delete("vabba","v") == ('abba',True)
          assert reverse_delete("mamma", "mia") == ("", True)

      """

  Scenario: Agent implements reverse_delete so all tests pass
    Given an agent is tasked with implementing the reverse_delete function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
