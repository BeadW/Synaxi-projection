Feature: HumanEval/19 — implement sort_numbers
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      from typing import List


      def sort_numbers(numbers: str) -> str:
          ''' Input is a space-delimited string of numberals from 'zero' to 'nine'.
          Valid choices are 'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight' and 'nine'.
          Return the string with numbers sorted from smallest to largest
          >>> sort_numbers('three one five')
          'one three five'
          '''
          pass

      === test_solution.py ===
      from solution import sort_numbers


      def test_humaneval():
          assert sort_numbers('') == ''
          assert sort_numbers('three') == 'three'
          assert sort_numbers('three five nine') == 'three five nine'
          assert sort_numbers('five zero four seven nine eight') == 'zero four five seven eight nine'
          assert sort_numbers('six five four three two one zero') == 'zero one two three four five six'

      """

  Scenario: Agent implements sort_numbers so all tests pass
    Given an agent is tasked with implementing the sort_numbers function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
