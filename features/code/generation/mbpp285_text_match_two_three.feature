Feature: MBPP/285 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def text_match_two_three():
          pass

      === test_solution.py ===
      from solution import text_match_two_three


      def test_mbpp():
          assert text_match_two_three("ac")==(False)
          assert text_match_two_three("dc")==(False)
          assert text_match_two_three("abbbba")==(True)

      """

  Scenario: Agent implements text_match_two_three so all pytest tests pass
    Given an agent is tasked with implementing the text_match_two_three function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
