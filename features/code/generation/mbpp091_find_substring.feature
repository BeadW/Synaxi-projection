Feature: MBPP/91 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def find_substring(str1, sub_str):
          pass

      === test_solution.py ===
      from solution import find_substring


      def test_mbpp():
          assert find_substring(["red", "black", "white", "green", "orange"],"ack")==True
          assert find_substring(["red", "black", "white", "green", "orange"],"abc")==False
          assert find_substring(["red", "black", "white", "green", "orange"],"ange")==True

      """

  Scenario: Agent implements find_substring so all pytest tests pass
    Given an agent is tasked with implementing the find_substring function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
