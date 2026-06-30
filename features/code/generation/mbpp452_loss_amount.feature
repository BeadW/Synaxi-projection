Feature: MBPP/452 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def loss_amount(actual_cost,sale_amount):
          pass

      === test_solution.py ===
      from solution import loss_amount


      def test_mbpp():
          assert loss_amount(1500,1200)==0
          assert loss_amount(100,200)==100
          assert loss_amount(2000,5000)==3000

      """

  Scenario: Agent implements loss_amount so all pytest tests pass
    Given an agent is tasked with implementing the loss_amount function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
