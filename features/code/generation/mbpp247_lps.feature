Feature: MBPP/247 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def lps(str):
          pass

      === test_solution.py ===
      from solution import lps


      def test_mbpp():
          assert lps("TENS FOR TENS") == 5
          assert lps("CARDIO FOR CARDS") == 7
          assert lps("PART OF THE JOURNEY IS PART") == 9

      """

  Scenario: Agent implements lps so all pytest tests pass
    Given an agent is tasked with implementing the lps function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
