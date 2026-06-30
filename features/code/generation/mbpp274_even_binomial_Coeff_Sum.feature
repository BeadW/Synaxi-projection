Feature: MBPP/274 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def even_binomial_Coeff_Sum():
          pass

      === test_solution.py ===
      from solution import even_binomial_Coeff_Sum


      def test_mbpp():
          assert even_binomial_Coeff_Sum(4) == 8
          assert even_binomial_Coeff_Sum(6) == 32
          assert even_binomial_Coeff_Sum(2) == 2

      """

  Scenario: Agent implements even_binomial_Coeff_Sum so all pytest tests pass
    Given an agent is tasked with implementing the even_binomial_Coeff_Sum function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
