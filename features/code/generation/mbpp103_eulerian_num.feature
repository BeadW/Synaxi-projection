Feature: MBPP/103 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def eulerian_num(n, m):
          pass

      === test_solution.py ===
      from solution import eulerian_num


      def test_mbpp():
          assert eulerian_num(3, 1) == 4
          assert eulerian_num(4, 1) == 11
          assert eulerian_num(5, 3) == 26

      """

  Scenario: Agent implements eulerian_num so all pytest tests pass
    Given an agent is tasked with implementing the eulerian_num function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
