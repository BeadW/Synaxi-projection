Feature: Fix an off-by-one error in a loop
  Complexity: T1
  Category: code/debug

  Background:
    Given the following broken Python code:
      """
      def sum_list(nums):
          total = 0
          for i in range(1, len(nums) + 1):
              total += nums[i]
          return total
      """

  Scenario: Agent produces code that returns correct sums
    Given an agent is tasked with fixing the bug
    When the agent completes the task
    Then running sum_list([1, 2, 3]) returns 6
    And running sum_list([]) returns 0
    And running sum_list([10]) returns 10
