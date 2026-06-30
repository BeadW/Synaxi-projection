Feature: MBPP/16 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def text_lowercase_underscore():
          pass

      === test_solution.py ===
      from solution import text_lowercase_underscore


      def test_mbpp():
          assert text_lowercase_underscore("aab_cbbbc")==(True)
          assert text_lowercase_underscore("aab_Abbbc")==(False)
          assert text_lowercase_underscore("Aaab_abbbc")==(False)

      """

  Scenario: Agent implements text_lowercase_underscore so all pytest tests pass
    Given an agent is tasked with implementing the text_lowercase_underscore function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
