Feature: Generate a binary search implementation
  Complexity: T2
  Category: code/generation

  Scenario: Agent writes a correct binary search function
    Given an agent is tasked with writing a Python function called binary_search that takes a sorted list and a target value, returning the index of the target or -1 if not found
    When the agent completes the task
    Then the code execution script passes:
      """
      assert binary_search([1, 3, 5, 7, 9], 5) == 2
      assert binary_search([1, 3, 5, 7, 9], 1) == 0
      assert binary_search([1, 3, 5, 7, 9], 9) == 4
      assert binary_search([1, 3, 5, 7, 9], 4) == -1
      assert binary_search([], 1) == -1
      assert binary_search([42], 42) == 0
      assert binary_search([42], 1) == -1
      """
