Feature: MBPP/454 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def text_match_wordz():
          pass

      === test_solution.py ===
      from solution import text_match_wordz


      def test_mbpp():
          assert text_match_wordz("pythonz.")==True
          assert text_match_wordz("xyz.")==True
          assert text_match_wordz("  lang  .")==False

      """

  Scenario: Agent implements text_match_wordz so all pytest tests pass
    Given an agent is tasked with implementing the text_match_wordz function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
