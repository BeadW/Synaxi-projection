Feature: HumanEval/80 — implement is_happy
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def is_happy(s):
          '''You are given a string s.
          Your task is to check if the string is happy or not.
          A string is happy if its length is at least 3 and every 3 consecutive letters are distinct
          For example:
          is_happy(a) => False
          is_happy(aa) => False
          is_happy(abcd) => True
          is_happy(aabb) => False
          is_happy(adb) => True
          is_happy(xyy) => False
          '''
          pass

      === test_solution.py ===
      from solution import is_happy


      def test_humaneval():

          # Check some simple cases
          assert is_happy("a") == False , "a"
          assert is_happy("aa") == False , "aa"
          assert is_happy("abcd") == True , "abcd"
          assert is_happy("aabb") == False , "aabb"
          assert is_happy("adb") == True , "adb"
          assert is_happy("xyy") == False , "xyy"
          assert is_happy("iopaxpoi") == True , "iopaxpoi"
          assert is_happy("iopaxioi") == False , "iopaxioi"

      """

  Scenario: Agent implements is_happy so all tests pass
    Given an agent is tasked with implementing the is_happy function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
