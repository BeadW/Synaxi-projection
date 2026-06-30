Feature: MBPP/478 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def remove_lowercase():
          pass

      === test_solution.py ===
      from solution import remove_lowercase


      def test_mbpp():
          assert remove_lowercase("PYTHon")==('PYTH')
          assert remove_lowercase("FInD")==('FID')
          assert remove_lowercase("STRinG")==('STRG')

      """

  Scenario: Agent implements remove_lowercase so all pytest tests pass
    Given an agent is tasked with implementing the remove_lowercase function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
