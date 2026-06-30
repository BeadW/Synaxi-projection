Feature: MBPP/131 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def reverse_vowels(str1):
          pass

      === test_solution.py ===
      from solution import reverse_vowels


      def test_mbpp():
          assert reverse_vowels("Python") == "Python"
          assert reverse_vowels("USA") == "ASU"
          assert reverse_vowels("ab") == "ab"

      """

  Scenario: Agent implements reverse_vowels so all pytest tests pass
    Given an agent is tasked with implementing the reverse_vowels function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
