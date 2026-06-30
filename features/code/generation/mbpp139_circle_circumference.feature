Feature: MBPP/139 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def circle_circumference(r):
          pass

      === test_solution.py ===
      from solution import circle_circumference


      def test_mbpp():
          assert math.isclose(circle_circumference(10), 62.830000000000005, rel_tol=0.001)
          assert math.isclose(circle_circumference(5), 31.415000000000003, rel_tol=0.001)
          assert math.isclose(circle_circumference(4), 25.132, rel_tol=0.001)

      """

  Scenario: Agent implements circle_circumference so all pytest tests pass
    Given an agent is tasked with implementing the circle_circumference function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
