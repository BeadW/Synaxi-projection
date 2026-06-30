Feature: HumanEval/154 — implement cycpattern_check
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def cycpattern_check(a , b):
          '''You are given 2 words. You need to return True if the second word or any of its rotations is a substring in the first word
          cycpattern_check("abcd","abd") => False
          cycpattern_check("hello","ell") => True
          cycpattern_check("whassup","psus") => False
          cycpattern_check("abab","baa") => True
          cycpattern_check("efef","eeff") => False
          cycpattern_check("himenss","simen") => True

          '''
          pass

      === test_solution.py ===
      from solution import cycpattern_check


      def test_humaneval():

          # Check some simple cases
          #assert True, "This prints if this assert fails 1 (good for debugging!)"

          # Check some edge cases that are easy to work out by hand.
          #assert True, "This prints if this assert fails 2 (also good for debugging!)"
          assert  cycpattern_check("xyzw","xyw") == False , "test #0"
          assert  cycpattern_check("yello","ell") == True , "test #1"
          assert  cycpattern_check("whattup","ptut") == False , "test #2"
          assert  cycpattern_check("efef","fee") == True , "test #3"
          assert  cycpattern_check("abab","aabb") == False , "test #4"
          assert  cycpattern_check("winemtt","tinem") == True , "test #5"


      """

  Scenario: Agent implements cycpattern_check so all tests pass
    Given an agent is tasked with implementing the cycpattern_check function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
