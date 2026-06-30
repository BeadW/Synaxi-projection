Feature: MBPP/451 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def remove_whitespaces():
          pass

      === test_solution.py ===
      from solution import remove_whitespaces


      def test_mbpp():
          assert remove_whitespaces(' Google    Flutter ') == 'GoogleFlutter'
          assert remove_whitespaces(' Google    Dart ') == 'GoogleDart'
          assert remove_whitespaces(' iOS    Swift ') == 'iOSSwift'

      """

  Scenario: Agent implements remove_whitespaces so all pytest tests pass
    Given an agent is tasked with implementing the remove_whitespaces function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
