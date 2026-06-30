Feature: HumanEval/56 — implement correct_bracketing
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def correct_bracketing(brackets: str):
          ''' brackets is a string of "<" and ">".
          return True if every opening bracket has a corresponding closing bracket.

          >>> correct_bracketing("<")
          False
          >>> correct_bracketing("<>")
          True
          >>> correct_bracketing("<<><>>")
          True
          >>> correct_bracketing("><<>")
          False
          '''
          pass

      === test_solution.py ===
      from solution import correct_bracketing


      def test_humaneval():
          assert correct_bracketing("<>")
          assert correct_bracketing("<<><>>")
          assert correct_bracketing("<><><<><>><>")
          assert correct_bracketing("<><><<<><><>><>><<><><<>>>")
          assert not correct_bracketing("<<<><>>>>")
          assert not correct_bracketing("><<>")
          assert not correct_bracketing("<")
          assert not correct_bracketing("<<<<")
          assert not correct_bracketing(">")
          assert not correct_bracketing("<<>")
          assert not correct_bracketing("<><><<><>><>><<>")
          assert not correct_bracketing("<><><<><>><>>><>")


      """

  Scenario: Agent implements correct_bracketing so all tests pass
    Given an agent is tasked with implementing the correct_bracketing function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
