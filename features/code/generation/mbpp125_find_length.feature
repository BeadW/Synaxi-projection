Feature: MBPP/125 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def find_length(string):
          pass

      === test_solution.py ===
      from solution import find_length


      def test_mbpp():
          assert find_length("11000010001") == 6
          assert find_length("10111") == 1
          assert find_length("11011101100101") == 2

      """

  Scenario: Agent implements find_length so all pytest tests pass
    Given an agent is tasked with implementing the find_length function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
