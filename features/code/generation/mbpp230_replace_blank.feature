Feature: MBPP/230 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def replace_blank(str1,char):
          pass

      === test_solution.py ===
      from solution import replace_blank


      def test_mbpp():
          assert replace_blank("hello people",'@')==("hello@people")
          assert replace_blank("python program language",'$')==("python$program$language")
          assert replace_blank("blank space","-")==("blank-space")

      """

  Scenario: Agent implements replace_blank so all pytest tests pass
    Given an agent is tasked with implementing the replace_blank function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
