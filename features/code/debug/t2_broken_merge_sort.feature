Feature: Fix a broken merge sort implementation
  Complexity: T2
  Category: code/debug

  Background:
    Given the following broken Python code:
      """
      def merge_sort(arr):
          if len(arr) <= 1:
              return arr
          mid = len(arr) // 2
          left = merge_sort(arr[:mid])
          right = merge_sort(arr[mid:])
          return merge(left, right)

      def merge(left, right):
          result = []
          i = j = 0
          while i < len(left) and j < len(right):
              if left[i] < right[j]:
                  result.append(left[i])
                  i += 1
              else:
                  result.append(right[j])
                  j += 1
          result.extend(left[i:])
          return result
      """

  Scenario: Agent produces a correct merge sort
    Given an agent is tasked with fixing the bug
    When the agent completes the task
    Then the code execution script passes:
      """
      assert merge_sort([]) == []
      assert merge_sort([1]) == [1]
      assert merge_sort([3, 1, 2]) == [1, 2, 3]
      assert merge_sort([5, 4, 3, 2, 1]) == [1, 2, 3, 4, 5]
      assert merge_sort([1, 1, 2, 1]) == [1, 1, 1, 2]
      """
