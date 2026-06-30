Feature: MBPP/412 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def remove_odd(l):
          pass

      === test_solution.py ===
      from solution import remove_odd


      def test_mbpp():
          assert remove_odd([1,2,3]) == [2]
          assert remove_odd([2,4,6]) == [2,4,6]
          assert remove_odd([10,20,3]) == [10,20]

      """

  Scenario: Agent implements remove_odd so all pytest tests pass
    Given an agent is tasked with implementing the remove_odd function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
