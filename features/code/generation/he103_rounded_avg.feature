Feature: HumanEval/103 — implement rounded_avg
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def rounded_avg(n, m):
          '''You are given two positive integers n and m, and your task is to compute the
          average of the integers from n through m (including n and m). 
          Round the answer to the nearest integer and convert that to binary.
          If n is greater than m, return -1.
          Example:
          rounded_avg(1, 5) => "0b11"
          rounded_avg(7, 5) => -1
          rounded_avg(10, 20) => "0b1111"
          rounded_avg(20, 33) => "0b11010"
          '''
          pass

      === test_solution.py ===
      from solution import rounded_avg


      def test_humaneval():

          # Check some simple cases
          assert rounded_avg(1, 5) == "0b11"
          assert rounded_avg(7, 13) == "0b1010"
          assert rounded_avg(964,977) == "0b1111001010"
          assert rounded_avg(996,997) == "0b1111100100"
          assert rounded_avg(560,851) == "0b1011000010"
          assert rounded_avg(185,546) == "0b101101110"
          assert rounded_avg(362,496) == "0b110101101"
          assert rounded_avg(350,902) == "0b1001110010"
          assert rounded_avg(197,233) == "0b11010111"


          # Check some edge cases that are easy to work out by hand.
          assert rounded_avg(7, 5) == -1
          assert rounded_avg(5, 1) == -1
          assert rounded_avg(5, 5) == "0b101"


      """

  Scenario: Agent implements rounded_avg so all tests pass
    Given an agent is tasked with implementing the rounded_avg function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
