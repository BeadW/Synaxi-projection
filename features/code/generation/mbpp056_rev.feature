Feature: MBPP/56 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def rev(num):
          pass

      === test_solution.py ===
      from solution import rev


      def test_mbpp():
          assert check(70) == False
          assert check(23) == False
          assert check(73) == True

      """

  Scenario: Agent implements rev so all pytest tests pass
    Given an agent is tasked with implementing the rev function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
