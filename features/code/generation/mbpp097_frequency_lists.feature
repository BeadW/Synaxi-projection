Feature: MBPP/97 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def frequency_lists(list1):
          pass

      === test_solution.py ===
      from solution import frequency_lists


      def test_mbpp():
          assert frequency_lists([[1, 2, 3, 2], [4, 5, 6, 2], [7, 8, 9, 5]])=={1: 1, 2: 3, 3: 1, 4: 1, 5: 2, 6: 1, 7: 1, 8: 1, 9: 1}
          assert frequency_lists([[1,2,3,4],[5,6,7,8],[9,10,11,12]])=={1: 1, 2: 1, 3: 1, 4: 1, 5: 1, 6: 1, 7: 1, 8: 1, 9: 1,10:1,11:1,12:1}
          assert frequency_lists([[20,30,40,17],[18,16,14,13],[10,20,30,40]])=={20:2,30:2,40:2,17: 1,18:1, 16: 1,14: 1,13: 1, 10: 1}

      """

  Scenario: Agent implements frequency_lists so all pytest tests pass
    Given an agent is tasked with implementing the frequency_lists function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
