Feature: Generate a function to check if a string is a palindrome
  Complexity: T1
  Category: code/generation

  Scenario: Agent writes a working palindrome checker
    Given an agent is tasked with writing a Python function called is_palindrome that returns True if a string reads the same forwards and backwards, ignoring case
    When the agent completes the task
    Then running is_palindrome("racecar") returns True
    And running is_palindrome("Racecar") returns True
    And running is_palindrome("hello") returns False
    And running is_palindrome("") returns True
    And running is_palindrome("A") returns True
