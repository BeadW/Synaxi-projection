Feature: MBPP/257 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def swap_numbers(a,b):
          pass

      === test_solution.py ===
      from solution import swap_numbers


      def test_mbpp():
          assert swap_numbers(10,20)==(20,10)
          assert swap_numbers(15,17)==(17,15)
          assert swap_numbers(100,200)==(200,100)

      """

  Scenario: Agent implements swap_numbers so all pytest tests pass
    Given an agent is tasked with implementing the swap_numbers function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
