Feature: MBPP/437 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def remove_odd(str1):
          pass

      === test_solution.py ===
      from solution import remove_odd


      def test_mbpp():
          assert remove_odd("python")==("yhn")
          assert remove_odd("program")==("rga")
          assert remove_odd("language")==("agae")

      """

  Scenario: Agent implements remove_odd so all pytest tests pass
    Given an agent is tasked with implementing the remove_odd function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
