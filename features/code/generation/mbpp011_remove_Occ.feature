Feature: MBPP/11 — 
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def remove_Occ(s,ch):
          pass

      === test_solution.py ===
      from solution import remove_Occ


      def test_mbpp():
          assert remove_Occ("hello","l") == "heo"
          assert remove_Occ("abcda","a") == "bcd"
          assert remove_Occ("PHP","P") == "H"

      """

  Scenario: Agent implements remove_Occ so all pytest tests pass
    Given an agent is tasked with implementing the remove_Occ function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
