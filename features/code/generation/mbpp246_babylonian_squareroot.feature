Feature: MBPP/246 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def babylonian_squareroot(number):
          pass

      === test_solution.py ===
      from solution import babylonian_squareroot


      def test_mbpp():
          assert math.isclose(babylonian_squareroot(10), 3.162277660168379, rel_tol=0.001)
          assert math.isclose(babylonian_squareroot(2), 1.414213562373095, rel_tol=0.001)
          assert math.isclose(babylonian_squareroot(9), 3.0, rel_tol=0.001)

      """

  Scenario: Agent implements babylonian_squareroot so all pytest tests pass
    Given an agent is tasked with implementing the babylonian_squareroot function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
