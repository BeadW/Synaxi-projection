Feature: MBPP/67 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def bell_number(n):
          pass

      === test_solution.py ===
      from solution import bell_number


      def test_mbpp():
          assert bell_number(2)==2
          assert bell_number(10)==115975
          assert bell_number(56)==6775685320645824322581483068371419745979053216268760300

      """

  Scenario: Agent implements bell_number so all pytest tests pass
    Given an agent is tasked with implementing the bell_number function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
