Feature: MBPP/425 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def count_element_in_list(list1, x):
          pass

      === test_solution.py ===
      from solution import count_element_in_list


      def test_mbpp():
          assert count_element_in_list([[1, 3], [5, 7], [1, 11], [1, 15, 7]],1)==3
          assert count_element_in_list([['A', 'B'], ['A', 'C'], ['A', 'D', 'E'], ['B', 'C', 'D']],'A')==3
          assert count_element_in_list([['A', 'B'], ['A', 'C'], ['A', 'D', 'E'], ['B', 'C', 'D']],'E')==1

      """

  Scenario: Agent implements count_element_in_list so all pytest tests pass
    Given an agent is tasked with implementing the count_element_in_list function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
