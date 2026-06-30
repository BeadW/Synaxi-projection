Feature: HumanEval/89 — implement encrypt
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def encrypt(s):
          '''Create a function encrypt that takes a string as an argument and
          returns a string encrypted with the alphabet being rotated. 
          The alphabet should be rotated in a manner such that the letters 
          shift down by two multiplied to two places.
          For example:
          encrypt('hi') returns 'lm'
          encrypt('asdfghjkl') returns 'ewhjklnop'
          encrypt('gf') returns 'kj'
          encrypt('et') returns 'ix'
          '''
          pass

      === test_solution.py ===
      from solution import encrypt


      def test_humaneval():

          # Check some simple cases
          assert encrypt('hi') == 'lm', "This prints if this assert fails 1 (good for debugging!)"
          assert encrypt('asdfghjkl') == 'ewhjklnop', "This prints if this assert fails 1 (good for debugging!)"
          assert encrypt('gf') == 'kj', "This prints if this assert fails 1 (good for debugging!)"
          assert encrypt('et') == 'ix', "This prints if this assert fails 1 (good for debugging!)"

          assert encrypt('faewfawefaewg')=='jeiajeaijeiak', "This prints if this assert fails 1 (good for debugging!)"
          assert encrypt('hellomyfriend')=='lippsqcjvmirh', "This prints if this assert fails 2 (good for debugging!)"
          assert encrypt('dxzdlmnilfuhmilufhlihufnmlimnufhlimnufhfucufh')=='hbdhpqrmpjylqmpyjlpmlyjrqpmqryjlpmqryjljygyjl', "This prints if this assert fails 3 (good for debugging!)"

          # Check some edge cases that are easy to work out by hand.
          assert encrypt('a')=='e', "This prints if this assert fails 2 (also good for debugging!)"


      """

  Scenario: Agent implements encrypt so all tests pass
    Given an agent is tasked with implementing the encrypt function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
