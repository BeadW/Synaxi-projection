Feature: MBPP/434 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def text_match_one():
          pass

      === test_solution.py ===
      from solution import text_match_one


      def test_mbpp():
          assert text_match_one("ac")==False
          assert text_match_one("dc")==False
          assert text_match_one("abba")==True

      """

  Scenario: Agent implements text_match_one so all pytest tests pass
    Given an agent is tasked with implementing the text_match_one function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
