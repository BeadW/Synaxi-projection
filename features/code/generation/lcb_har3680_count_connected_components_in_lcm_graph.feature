Feature: LiveCodeBench/leetcode/hard — count-connected-components-in-lcm-graph
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given an array of integers nums of size n and a positive integer threshold.
      There is a graph consisting of n nodes with the i^th node having a value of nums[i]. Two nodes i and j in the graph are connected via an undirected edge if lcm(nums[i], nums[j]) <= threshold.
      Return the number of connected components in this graph.
      A connected component is a subgraph of a graph in which there exists a path between any two vertices, and no vertex of the subgraph shares an edge with a vertex outside of the subgraph.
      The term lcm(a, b) denotes the least common multiple of a and b.
 
      Example 1:

      Input: nums = [2,4,8,3,9], threshold = 5
      Output: 4
      Explanation: 

 
      The four connected components are (2, 4), (3), (8), (9).

      Example 2:

      Input: nums = [2,4,8,3,9,12], threshold = 10
      Output: 2
      Explanation: 

      The two connected components are (2, 3, 4, 8, 9), and (12).

 
      Constraints:

      1 <= nums.length <= 10^5
      1 <= nums[i] <= 10^9
      All elements of nums are unique.
      1 <= threshold <= 2 * 10^5

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "[2, 4, 8, 3, 9]\n5",
              "4"
          ],
          [
              "[2, 4, 8, 3, 9, 12]\n10",
              "2"
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
