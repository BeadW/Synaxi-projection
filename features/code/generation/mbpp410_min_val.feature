Feature: MBPP/410 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def min_val(listval):
          pass

      === test_solution.py ===
      from solution import min_val


      def test_mbpp():
          assert min_val(['Python', 3, 2, 4, 5, 'version'])==2
          assert min_val(['Python', 15, 20, 25])==15
          assert min_val(['Python', 30, 20, 40, 50, 'version'])==20

      """

  Scenario: Agent implements min_val so all pytest tests pass
    Given an agent is tasked with implementing the min_val function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
