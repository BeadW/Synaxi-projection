Feature: MBPP/399 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def bitwise_xor(test_tup1, test_tup2):
          pass

      === test_solution.py ===
      from solution import bitwise_xor


      def test_mbpp():
          assert bitwise_xor((10, 4, 6, 9), (5, 2, 3, 3)) == (15, 6, 5, 10)
          assert bitwise_xor((11, 5, 7, 10), (6, 3, 4, 4)) == (13, 6, 3, 14)
          assert bitwise_xor((12, 6, 8, 11), (7, 4, 5, 6)) == (11, 2, 13, 13)

      """

  Scenario: Agent implements bitwise_xor so all pytest tests pass
    Given an agent is tasked with implementing the bitwise_xor function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
