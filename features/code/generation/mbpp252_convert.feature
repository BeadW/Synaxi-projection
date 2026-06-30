Feature: MBPP/252 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def convert():
          pass

      === test_solution.py ===
      from solution import convert


      def test_mbpp():
          assert convert(1) == (1.0, 0.0)
          assert convert(4) == (4.0,0.0)
          assert convert(5) == (5.0,0.0)

      """

  Scenario: Agent implements convert so all pytest tests pass
    Given an agent is tasked with implementing the convert function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
