Feature: HumanEval/105 — implement by_length
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def by_length(arr):
          '''
          Given an array of integers, sort the integers that are between 1 and 9 inclusive,
          reverse the resulting array, and then replace each digit by its corresponding name from
          "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine".

          For example:
            arr = [2, 1, 1, 4, 5, 8, 2, 3]   
                  -> sort arr -> [1, 1, 2, 2, 3, 4, 5, 8] 
                  -> reverse arr -> [8, 5, 4, 3, 2, 2, 1, 1]
            return ["Eight", "Five", "Four", "Three", "Two", "Two", "One", "One"]
    
            If the array is empty, return an empty array:
            arr = []
            return []
    
            If the array has any strange number ignore it:
            arr = [1, -1 , 55] 
                  -> sort arr -> [-1, 1, 55]
                  -> reverse arr -> [55, 1, -1]
            return = ['One']
          '''
          pass

      === test_solution.py ===
      from solution import by_length


      def test_humaneval():

          # Check some simple cases
          assert True, "This prints if this assert fails 1 (good for debugging!)"
          assert by_length([2, 1, 1, 4, 5, 8, 2, 3]) == ["Eight", "Five", "Four", "Three", "Two", "Two", "One", "One"], "Error"
          assert by_length([]) == [], "Error"
          assert by_length([1, -1 , 55]) == ['One'], "Error"

          # Check some edge cases that are easy to work out by hand.
          assert True, "This prints if this assert fails 2 (also good for debugging!)"
          assert by_length([1, -1, 3, 2]) == ["Three", "Two", "One"]
          assert by_length([9, 4, 8]) == ["Nine", "Eight", "Four"]


      """

  Scenario: Agent implements by_length so all tests pass
    Given an agent is tasked with implementing the by_length function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
