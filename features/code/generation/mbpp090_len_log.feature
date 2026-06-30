Feature: MBPP/90 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def len_log(list1):
          pass

      === test_solution.py ===
      from solution import len_log


      def test_mbpp():
          assert len_log(["python","PHP","bigdata"]) == 7
          assert len_log(["a","ab","abc"]) == 3
          assert len_log(["small","big","tall"]) == 5

      """

  Scenario: Agent implements len_log so all pytest tests pass
    Given an agent is tasked with implementing the len_log function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
