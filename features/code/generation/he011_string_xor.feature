Feature: HumanEval/11 — implement string_xor
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      from typing import List


      def string_xor(a: str, b: str) -> str:
          ''' Input are two strings a and b consisting only of 1s and 0s.
          Perform binary XOR on these inputs and return result also as a string.
          >>> string_xor('010', '110')
          '100'
          '''
          pass

      === test_solution.py ===
      from solution import string_xor


      def test_humaneval():
          assert string_xor('111000', '101010') == '010010'
          assert string_xor('1', '1') == '0'
          assert string_xor('0101', '0000') == '0101'

      """

  Scenario: Agent implements string_xor so all tests pass
    Given an agent is tasked with implementing the string_xor function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
