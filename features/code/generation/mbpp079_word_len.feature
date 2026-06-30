Feature: MBPP/79 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def word_len(s):
          pass

      === test_solution.py ===
      from solution import word_len


      def test_mbpp():
          assert word_len("Hadoop") == False
          assert word_len("great") == True
          assert word_len("structure") == True

      """

  Scenario: Agent implements word_len so all pytest tests pass
    Given an agent is tasked with implementing the word_len function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
