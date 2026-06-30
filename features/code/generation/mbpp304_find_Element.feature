Feature: MBPP/304 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def find_Element(arr,ranges,rotations,index) :
          pass

      === test_solution.py ===
      from solution import find_Element


      def test_mbpp():
          assert find_Element([1,2,3,4,5],[[0,2],[0,3]],2,1) == 3
          assert find_Element([1,2,3,4],[[0,1],[0,2]],1,2) == 3
          assert find_Element([1,2,3,4,5,6],[[0,1],[0,2]],1,1) == 1

      """

  Scenario: Agent implements find_Element so all pytest tests pass
    Given an agent is tasked with implementing the find_Element function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
