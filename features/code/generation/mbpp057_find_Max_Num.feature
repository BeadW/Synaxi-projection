Feature: MBPP/57 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def find_Max_Num(arr) :
          pass

      === test_solution.py ===
      from solution import find_Max_Num


      def test_mbpp():
          assert find_Max_Num([1,2,3]) == 321
          assert find_Max_Num([4,5,6,1]) == 6541
          assert find_Max_Num([1,2,3,9]) == 9321

      """

  Scenario: Agent implements find_Max_Num so all pytest tests pass
    Given an agent is tasked with implementing the find_Max_Num function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
