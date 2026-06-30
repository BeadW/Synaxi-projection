Feature: HumanEval/93 — implement encode
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def encode(message):
          '''
          Write a function that takes a message, and encodes in such a 
          way that it swaps case of all letters, replaces all vowels in 
          the message with the letter that appears 2 places ahead of that 
          vowel in the english alphabet. 
          Assume only letters. 
    
          Examples:
          >>> encode('test')
          'TGST'
          >>> encode('This is a message')
          'tHKS KS C MGSSCGG'
          '''
          pass

      === test_solution.py ===
      from solution import encode


      def test_humaneval():

          # Check some simple cases
          assert encode('TEST') == 'tgst', "This prints if this assert fails 1 (good for debugging!)"
          assert encode('Mudasir') == 'mWDCSKR', "This prints if this assert fails 2 (good for debugging!)"
          assert encode('YES') == 'ygs', "This prints if this assert fails 3 (good for debugging!)"

          # Check some edge cases that are easy to work out by hand.
          assert encode('This is a message') == 'tHKS KS C MGSSCGG', "This prints if this assert fails 2 (also good for debugging!)"
          assert encode("I DoNt KnOw WhAt tO WrItE") == 'k dQnT kNqW wHcT Tq wRkTg', "This prints if this assert fails 2 (also good for debugging!)"


      """

  Scenario: Agent implements encode so all tests pass
    Given an agent is tasked with implementing the encode function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
