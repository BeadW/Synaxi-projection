Feature: HumanEval/155 — implement even_odd_count
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def even_odd_count(num):
          '''Given an integer. return a tuple that has the number of even and odd digits respectively.

           Example:
              even_odd_count(-12) ==> (1, 1)
              even_odd_count(123) ==> (1, 2)
          '''
          pass

      === test_solution.py ===
      from solution import even_odd_count


      def test_humaneval():

          # Check some simple cases
          assert even_odd_count(7) == (0, 1)
          assert even_odd_count(-78) == (1, 1)
          assert even_odd_count(3452) == (2, 2)
          assert even_odd_count(346211) == (3, 3)
          assert even_odd_count(-345821) == (3, 3)
          assert even_odd_count(-2) == (1, 0)
          assert even_odd_count(-45347) == (2, 3)
          assert even_odd_count(0) == (1, 0)


          # Check some edge cases that are easy to work out by hand.
          assert True


      """

  Scenario: Agent implements even_odd_count so all tests pass
    Given an agent is tasked with implementing the even_odd_count function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
