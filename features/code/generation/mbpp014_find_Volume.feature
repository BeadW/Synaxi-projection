Feature: MBPP/14 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def find_Volume(l,b,h) :
          pass

      === test_solution.py ===
      from solution import find_Volume


      def test_mbpp():
          assert find_Volume(10,8,6) == 240
          assert find_Volume(3,2,2) == 6
          assert find_Volume(1,2,1) == 1

      """

  Scenario: Agent implements find_Volume so all pytest tests pass
    Given an agent is tasked with implementing the find_Volume function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
