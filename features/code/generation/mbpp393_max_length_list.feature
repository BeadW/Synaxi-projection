Feature: MBPP/393 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def max_length_list(input_list):
          pass

      === test_solution.py ===
      from solution import max_length_list


      def test_mbpp():
          assert max_length_list([[0], [1, 3], [5, 7], [9, 11], [13, 15, 17]])==(3, [13, 15, 17])
          assert max_length_list([[1,2,3,4,5],[1,2,3,4],[1,2,3],[1,2],[1]])==(5,[1,2,3,4,5])
          assert max_length_list([[3,4,5],[6,7,8,9],[10,11,12]])==(4,[6,7,8,9])

      """

  Scenario: Agent implements max_length_list so all pytest tests pass
    Given an agent is tasked with implementing the max_length_list function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
