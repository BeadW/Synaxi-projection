Feature: HumanEval/137 — implement compare_one
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def compare_one(a, b):
          '''
          Create a function that takes integers, floats, or strings representing
          real numbers, and returns the larger variable in its given variable type.
          Return None if the values are equal.
          Note: If a real number is represented as a string, the floating point might be . or ,

          compare_one(1, 2.5) ➞ 2.5
          compare_one(1, "2,3") ➞ "2,3"
          compare_one("5,1", "6") ➞ "6"
          compare_one("1", 1) ➞ None
          '''
          pass

      === test_solution.py ===
      from solution import compare_one


      def test_humaneval():

          # Check some simple cases
          assert compare_one(1, 2) == 2
          assert compare_one(1, 2.5) == 2.5
          assert compare_one(2, 3) == 3
          assert compare_one(5, 6) == 6
          assert compare_one(1, "2,3") == "2,3"
          assert compare_one("5,1", "6") == "6"
          assert compare_one("1", "2") == "2"
          assert compare_one("1", 1) == None

          # Check some edge cases that are easy to work out by hand.
          assert True


      """

  Scenario: Agent implements compare_one so all tests pass
    Given an agent is tasked with implementing the compare_one function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
