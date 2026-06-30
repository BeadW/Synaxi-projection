Feature: MBPP/227 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def min_of_three(a,b,c):
          pass

      === test_solution.py ===
      from solution import min_of_three


      def test_mbpp():
          assert min_of_three(10,20,0)==0
          assert min_of_three(19,15,18)==15
          assert min_of_three(-10,-20,-30)==-30

      """

  Scenario: Agent implements min_of_three so all pytest tests pass
    Given an agent is tasked with implementing the min_of_three function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
