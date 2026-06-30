Feature: MBPP/284 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def check_element(list,element):
          pass

      === test_solution.py ===
      from solution import check_element


      def test_mbpp():
          assert check_element(["green", "orange", "black", "white"],'blue')==False
          assert check_element([1,2,3,4],7)==False
          assert check_element(["green", "green", "green", "green"],'green')==True

      """

  Scenario: Agent implements check_element so all pytest tests pass
    Given an agent is tasked with implementing the check_element function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
