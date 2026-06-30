Feature: MBPP/235 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def even_bit_set_number(n):
          pass

      === test_solution.py ===
      from solution import even_bit_set_number


      def test_mbpp():
          assert even_bit_set_number(10) == 10
          assert even_bit_set_number(20) == 30
          assert even_bit_set_number(30) == 30

      """

  Scenario: Agent implements even_bit_set_number so all pytest tests pass
    Given an agent is tasked with implementing the even_bit_set_number function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
