Feature: HumanEval/161 — implement solve
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def solve(s):
          '''You are given a string s.
          if s[i] is a letter, reverse its case from lower to upper or vise versa, 
          otherwise keep it as it is.
          If the string contains no letters, reverse the string.
          The function should return the resulted string.
          Examples
          solve("1234") = "4321"
          solve("ab") = "AB"
          solve("#a@C") = "#A@c"
          '''
          pass

      === test_solution.py ===
      from solution import solve


      def test_humaneval():

          # Check some simple cases
          assert solve("AsDf") == "aSdF"
          assert solve("1234") == "4321"
          assert solve("ab") == "AB"
          assert solve("#a@C") == "#A@c"
          assert solve("#AsdfW^45") == "#aSDFw^45"
          assert solve("#6@2") == "2@6#"

          # Check some edge cases that are easy to work out by hand.
          assert solve("#$a^D") == "#$A^d"
          assert solve("#ccc") == "#CCC"

          # Don't remove this line:

      """

  Scenario: Agent implements solve so all tests pass
    Given an agent is tasked with implementing the solve function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
