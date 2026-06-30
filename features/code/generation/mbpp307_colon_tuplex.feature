Feature: MBPP/307 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def colon_tuplex():
          pass

      === test_solution.py ===
      from solution import colon_tuplex


      def test_mbpp():
          assert colon_tuplex(("HELLO", 5, [], True) ,2,50)==("HELLO", 5, [50], True)
          assert colon_tuplex(("HELLO", 5, [], True) ,2,100)==(("HELLO", 5, [100],True))
          assert colon_tuplex(("HELLO", 5, [], True) ,2,500)==("HELLO", 5, [500], True)

      """

  Scenario: Agent implements colon_tuplex so all pytest tests pass
    Given an agent is tasked with implementing the colon_tuplex function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
