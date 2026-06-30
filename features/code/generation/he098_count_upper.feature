Feature: HumanEval/98 — implement count_upper
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def count_upper(s):
          '''
          Given a string s, count the number of uppercase vowels in even indices.
    
          For example:
          count_upper('aBCdEf') returns 1
          count_upper('abcdefg') returns 0
          count_upper('dBBE') returns 0
          '''
          pass

      === test_solution.py ===
      from solution import count_upper


      def test_humaneval():

          # Check some simple cases
          assert count_upper('aBCdEf')  == 1
          assert count_upper('abcdefg') == 0
          assert count_upper('dBBE') == 0
          assert count_upper('B')  == 0
          assert count_upper('U')  == 1
          assert count_upper('') == 0
          assert count_upper('EEEE') == 2

          # Check some edge cases that are easy to work out by hand.
          assert True


      """

  Scenario: Agent implements count_upper so all tests pass
    Given an agent is tasked with implementing the count_upper function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
