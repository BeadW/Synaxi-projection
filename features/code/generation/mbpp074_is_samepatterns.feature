Feature: MBPP/74 — 
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def is_samepatterns(colors, patterns):
          pass

      === test_solution.py ===
      from solution import is_samepatterns


      def test_mbpp():
          assert is_samepatterns(["red","green","green"], ["a", "b", "b"])==True
          assert is_samepatterns(["red","green","greenn"], ["a","b","b"])==False
          assert is_samepatterns(["red","green","greenn"], ["a","b"])==False

      """

  Scenario: Agent implements is_samepatterns so all pytest tests pass
    Given an agent is tasked with implementing the is_samepatterns function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
