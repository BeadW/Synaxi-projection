Feature: HumanEval/85 — implement add
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def add(lst):
          '''Given a non-empty list of integers lst. add the even elements that are at odd indices..


          Examples:
              add([4, 2, 6, 7]) ==> 2 
          '''
          pass

      === test_solution.py ===
      from solution import add


      def test_humaneval():

          # Check some simple cases
          assert add([4, 88]) == 88
          assert add([4, 5, 6, 7, 2, 122]) == 122
          assert add([4, 0, 6, 7]) == 0
          assert add([4, 4, 6, 8]) == 12

          # Check some edge cases that are easy to work out by hand.


      """

  Scenario: Agent implements add so all tests pass
    Given an agent is tasked with implementing the add function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
