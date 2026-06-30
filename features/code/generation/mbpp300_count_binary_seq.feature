Feature: MBPP/300 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def count_binary_seq(n):
          pass

      === test_solution.py ===
      from solution import count_binary_seq


      def test_mbpp():
          assert math.isclose(count_binary_seq(1), 2.0, rel_tol=0.001)
          assert math.isclose(count_binary_seq(2), 6.0, rel_tol=0.001)
          assert math.isclose(count_binary_seq(3), 20.0, rel_tol=0.001)

      """

  Scenario: Agent implements count_binary_seq so all pytest tests pass
    Given an agent is tasked with implementing the count_binary_seq function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
