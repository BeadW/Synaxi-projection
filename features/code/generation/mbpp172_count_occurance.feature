Feature: MBPP/172 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def count_occurance(s):
          pass

      === test_solution.py ===
      from solution import count_occurance


      def test_mbpp():
          assert count_occurance("letstdlenstdporstd") == 3
          assert count_occurance("truststdsolensporsd") == 1
          assert count_occurance("makestdsostdworthit") == 2
          assert count_occurance("stds") == 1
          assert count_occurance("") == 0

      """

  Scenario: Agent implements count_occurance so all pytest tests pass
    Given an agent is tasked with implementing the count_occurance function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
