Feature: HumanEval/50 — implement decode_shift
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def encode_shift(s: str):
          '''
          returns encoded string by shifting every character by 5 in the alphabet.
          '''
          return "".join([chr(((ord(ch) + 5 - ord("a")) % 26) + ord("a")) for ch in s])


      def decode_shift(s: str):
          '''
          takes as input string encoded with encode_shift function. Returns decoded string.
          '''
          pass

      === test_solution.py ===
      from solution import decode_shift


      def test_humaneval():
          from random import randint, choice
          import copy
          import string

          letters = string.ascii_lowercase
          for _ in range(100):
              str = ''.join(choice(letters) for i in range(randint(10, 20)))
              encoded_str = encode_shift(str)
              assert decode_shift(copy.deepcopy(encoded_str)) == str


      """

  Scenario: Agent implements decode_shift so all tests pass
    Given an agent is tasked with implementing the decode_shift function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
