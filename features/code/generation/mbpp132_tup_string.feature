Feature: MBPP/132 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def tup_string(tup1):
          pass

      === test_solution.py ===
      from solution import tup_string


      def test_mbpp():
          assert tup_string(('e', 'x', 'e', 'r', 'c', 'i', 's', 'e', 's'))==("exercises")
          assert tup_string(('p','y','t','h','o','n'))==("python")
          assert tup_string(('p','r','o','g','r','a','m'))==("program")

      """

  Scenario: Agent implements tup_string so all pytest tests pass
    Given an agent is tasked with implementing the tup_string function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
