Feature: Generate a function to reverse a string
  Complexity: T1
  Category: code/generation

  Scenario: Agent writes a working string reversal function
    Given an agent is tasked with writing a Python function called reverse_string that takes a string and returns it reversed
    When the agent completes the task
    Then running reverse_string("hello") returns "olleh"
    And running reverse_string("") returns ""
    And running reverse_string("a") returns "a"
    And running reverse_string("abcd") returns "dcba"
