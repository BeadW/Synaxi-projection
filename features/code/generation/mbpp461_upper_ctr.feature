Feature: MBPP/461 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def upper_ctr(str):
          pass

      === test_solution.py ===
      from solution import upper_ctr


      def test_mbpp():
          assert upper_ctr('PYthon') == 1
          assert upper_ctr('BigData') == 1
          assert upper_ctr('program') == 0

      """

  Scenario: Agent implements upper_ctr so all pytest tests pass
    Given an agent is tasked with implementing the upper_ctr function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
