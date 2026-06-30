Feature: MBPP/474 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def replace_char(str1,ch,newch):
          pass

      === test_solution.py ===
      from solution import replace_char


      def test_mbpp():
          assert replace_char("polygon",'y','l')==("pollgon")
          assert replace_char("character",'c','a')==("aharaater")
          assert replace_char("python",'l','a')==("python")

      """

  Scenario: Agent implements replace_char so all pytest tests pass
    Given an agent is tasked with implementing the replace_char function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
