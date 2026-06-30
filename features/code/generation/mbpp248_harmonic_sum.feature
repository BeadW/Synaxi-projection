Feature: MBPP/248 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def harmonic_sum(n):
          pass

      === test_solution.py ===
      from solution import harmonic_sum


      def test_mbpp():
          assert math.isclose(harmonic_sum(7), 2.5928571428571425, rel_tol=0.001)
          assert math.isclose(harmonic_sum(4), 2.083333333333333, rel_tol=0.001)
          assert math.isclose(harmonic_sum(19), 3.547739657143682, rel_tol=0.001)

      """

  Scenario: Agent implements harmonic_sum so all pytest tests pass
    Given an agent is tasked with implementing the harmonic_sum function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
