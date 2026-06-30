Feature: HumanEval/82 — implement prime_length
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def prime_length(string):
          '''Write a function that takes a string and returns True if the string
          length is a prime number or False otherwise
          Examples
          prime_length('Hello') == True
          prime_length('abcdcba') == True
          prime_length('kittens') == True
          prime_length('orange') == False
          '''
          pass

      === test_solution.py ===
      from solution import prime_length


      def test_humaneval():

          # Check some simple cases
          assert prime_length('Hello') == True
          assert prime_length('abcdcba') == True
          assert prime_length('kittens') == True
          assert prime_length('orange') == False
          assert prime_length('wow') == True
          assert prime_length('world') == True
          assert prime_length('MadaM') == True
          assert prime_length('Wow') == True
          assert prime_length('') == False
          assert prime_length('HI') == True
          assert prime_length('go') == True
          assert prime_length('gogo') == False
          assert prime_length('aaaaaaaaaaaaaaa') == False

          # Check some edge cases that are easy to work out by hand.
          assert prime_length('Madam') == True
          assert prime_length('M') == False
          assert prime_length('0') == False


      """

  Scenario: Agent implements prime_length so all tests pass
    Given an agent is tasked with implementing the prime_length function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
