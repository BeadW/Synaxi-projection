Feature: MBPP/305 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def start_withp():
          pass

      === test_solution.py ===
      from solution import start_withp


      def test_mbpp():
          assert start_withp(["Python PHP", "Java JavaScript", "c c++"])==('Python', 'PHP')
          assert start_withp(["Python Programming","Java Programming"])==('Python','Programming')
          assert start_withp(["Pqrst Pqr","qrstuv"])==('Pqrst','Pqr')

      """

  Scenario: Agent implements start_withp so all pytest tests pass
    Given an agent is tasked with implementing the start_withp function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
