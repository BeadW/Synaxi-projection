Feature: HumanEval/66 — implement digitSum
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def digitSum(s):
          '''Task
          Write a function that takes a string as input and returns the sum of the upper characters only'
          ASCII codes.

          Examples:
              digitSum("") => 0
              digitSum("abAB") => 131
              digitSum("abcCd") => 67
              digitSum("helloE") => 69
              digitSum("woArBld") => 131
              digitSum("aAaaaXa") => 153
          '''
          pass

      === test_solution.py ===
      from solution import digitSum


      def test_humaneval():

          # Check some simple cases
          assert True, "This prints if this assert fails 1 (good for debugging!)"
          assert digitSum("") == 0, "Error"
          assert digitSum("abAB") == 131, "Error"
          assert digitSum("abcCd") == 67, "Error"
          assert digitSum("helloE") == 69, "Error"
          assert digitSum("woArBld") == 131, "Error"
          assert digitSum("aAaaaXa") == 153, "Error"

          # Check some edge cases that are easy to work out by hand.
          assert True, "This prints if this assert fails 2 (also good for debugging!)"
          assert digitSum(" How are yOu?") == 151, "Error"
          assert digitSum("You arE Very Smart") == 327, "Error"


      """

  Scenario: Agent implements digitSum so all tests pass
    Given an agent is tasked with implementing the digitSum function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
