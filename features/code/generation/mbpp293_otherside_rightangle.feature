Feature: MBPP/293 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def otherside_rightangle():
          pass

      === test_solution.py ===
      from solution import otherside_rightangle


      def test_mbpp():
          assert otherside_rightangle(7,8)==10.63014581273465
          assert otherside_rightangle(3,4)==5
          assert otherside_rightangle(7,15)==16.55294535724685

      """

  Scenario: Agent implements otherside_rightangle so all pytest tests pass
    Given an agent is tasked with implementing the otherside_rightangle function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
