Feature: MBPP/115 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def empty_dit(list1):
          pass

      === test_solution.py ===
      from solution import empty_dit


      def test_mbpp():
          assert empty_dit([{},{},{}])==True
          assert empty_dit([{1,2},{},{}])==False
          assert empty_dit({})==True

      """

  Scenario: Agent implements empty_dit so all pytest tests pass
    Given an agent is tasked with implementing the empty_dit function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
