Feature: MBPP/262 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def split_two_parts(list1, L):
          pass

      === test_solution.py ===
      from solution import split_two_parts


      def test_mbpp():
          assert split_two_parts([1,1,2,3,4,4,5,1],3)==([1, 1, 2], [3, 4, 4, 5, 1])
          assert split_two_parts(['a', 'b', 'c', 'd'],2)==(['a', 'b'], ['c', 'd'])
          assert split_two_parts(['p', 'y', 't', 'h', 'o', 'n'],4)==(['p', 'y', 't', 'h'], ['o', 'n'])

      """

  Scenario: Agent implements split_two_parts so all pytest tests pass
    Given an agent is tasked with implementing the split_two_parts function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
