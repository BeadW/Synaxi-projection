Feature: LiveCodeBench/leetcode/hard — find-the-number-of-subarrays-where-boundary-elements-are-maximum
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an array of positive integers nums.
      Return the number of subarrays of nums, where the first and the last elements of the subarray are equal to the largest element in the subarray.
 
      Example 1:

      Input: nums = [1,4,3,3,2]
      Output: 6
      Explanation:
      There are 6 subarrays which have the first and the last elements equal to the largest element of the subarray:

      subarray [1,4,3,3,2], with its largest element 1. The first element is 1 and the last element is also 1.
      subarray [1,4,3,3,2], with its largest element 4. The first element is 4 and the last element is also 4.
      subarray [1,4,3,3,2], with its largest element 3. The first element is 3 and the last element is also 3.
      subarray [1,4,3,3,2], with its largest element 3. The first element is 3 and the last element is also 3.
      subarray [1,4,3,3,2], with its largest element 2. The first element is 2 and the last element is also 2.
      subarray [1,4,3,3,2], with its largest element 3. The first element is 3 and the last element is also 3.

      Hence, we return 6.

      Example 2:

      Input: nums = [3,3,3]
      Output: 6
      Explanation:
      There are 6 subarrays which have the first and the last elements equal to the largest element of the subarray:

      subarray [3,3,3], with its largest element 3. The first element is 3 and the last element is also 3.
      subarray [3,3,3], with its largest element 3. The first element is 3 and the last element is also 3.
      subarray [3,3,3], with its largest element 3. The first element is 3 and the last element is also 3.
      subarray [3,3,3], with its largest element 3. The first element is 3 and the last element is also 3.
      subarray [3,3,3], with its largest element 3. The first element is 3 and the last element is also 3.
      subarray [3,3,3], with its largest element 3. The first element is 3 and the last element is also 3.

      Hence, we return 6.

      Example 3:

      Input: nums = [1]
      Output: 1
      Explanation:
      There is a single subarray of nums which is [1], with its largest element 1. The first element is 1 and the last element is also 

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[1, 4, 3, 3, 2]",
              "6"
          ],
          [
              "[3, 3, 3]",
              "6"
          ],
          [
              "[1]",
              "1"
          ]
      ]


      def test_lcb():
          for i, (inp, expected) in enumerate(TEST_CASES):
              r = subprocess.run(
                  [sys.executable, "solution.py"],
                  input=inp,
                  capture_output=True,
                  text=True,
                  timeout=10,
              )
              assert r.returncode == 0, f"Case {i}: runtime error\n{r.stderr[:400]}"
              assert r.stdout.strip() == expected.strip(), (
                  f"Case {i}: expected {expected!r}, got {r.stdout!r}"
              )

      """

  Scenario: Agent solves the LiveCodeBench problem so all tests pass
    Given an agent is tasked with reading problem.txt and implementing solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
