Feature: MBPP/260 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def newman_prime(n):
          pass

      === test_solution.py ===
      from solution import newman_prime


      def test_mbpp():
          assert newman_prime(3) == 7
          assert newman_prime(4) == 17
          assert newman_prime(5) == 41

      """

  Scenario: Agent implements newman_prime so all pytest tests pass
    Given an agent is tasked with implementing the newman_prime function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
