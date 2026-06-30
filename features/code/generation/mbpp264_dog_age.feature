Feature: MBPP/264 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def dog_age(h_age):
          pass

      === test_solution.py ===
      from solution import dog_age


      def test_mbpp():
          assert dog_age(12)==61
          assert dog_age(15)==73
          assert dog_age(24)==109

      """

  Scenario: Agent implements dog_age so all pytest tests pass
    Given an agent is tasked with implementing the dog_age function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
