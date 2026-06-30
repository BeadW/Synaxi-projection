Feature: MBPP/431 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def common_element(list1, list2):
          pass

      === test_solution.py ===
      from solution import common_element


      def test_mbpp():
          assert common_element([1,2,3,4,5], [5,6,7,8,9])==True
          assert common_element([1,2,3,4,5], [6,7,8,9])==None
          assert common_element(['a','b','c'], ['d','b','e'])==True

      """

  Scenario: Agent implements common_element so all pytest tests pass
    Given an agent is tasked with implementing the common_element function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
