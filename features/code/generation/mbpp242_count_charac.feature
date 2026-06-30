Feature: MBPP/242 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def count_charac(str1):
          pass

      === test_solution.py ===
      from solution import count_charac


      def test_mbpp():
          assert count_charac("python programming")==18
          assert count_charac("language")==8
          assert count_charac("words")==5

      """

  Scenario: Agent implements count_charac so all pytest tests pass
    Given an agent is tasked with implementing the count_charac function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
