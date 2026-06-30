Feature: MBPP/98 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def multiply_num(numbers):
          pass

      === test_solution.py ===
      from solution import multiply_num


      def test_mbpp():
          assert math.isclose(multiply_num((8, 2, 3, -1, 7)), -67.2, rel_tol=0.001)
          assert math.isclose(multiply_num((-10,-20,-30)), -2000.0, rel_tol=0.001)
          assert math.isclose(multiply_num((19,15,18)), 1710.0, rel_tol=0.001)

      """

  Scenario: Agent implements multiply_num so all pytest tests pass
    Given an agent is tasked with implementing the multiply_num function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
