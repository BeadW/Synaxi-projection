Feature: LiveCodeBench/atcoder/hard — Roadway
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There are N towns, numbered 1,2,\ldots,N, arranged in a line in this order.
      There are N-1 roads connecting adjacent towns: road j\,(1 \leq j \leq N-1) connects towns j and j+1. For each road j, you can set a strength w_j (an integer that may be negative).
      When a person travels along a road, their stamina changes. Specifically, if a person with stamina x travels along road j, their stamina becomes x + w_j.
      There are M people who will now move between these towns.
      Person i\,(1 \le i \le M) starts with stamina 0 at town S_i and travels to town T_i via the shortest path.
      It is guaranteed that |S_i - T_i| > 1. Also, (S_i, T_i) \neq (S_j, T_j) if i \neq j.
      Person i’s requirement is as follows:

      When departing Town S_i and when arriving at Town T_i, their stamina should be exactly 0. At every other town, their stamina should always be a positive integer.

      Assume that there are no changes to stamina other than those due to traveling along roads as described above.
      Process Q queries. For the k-th query (1 \le k \le Q), if it is possible to set the strengths of the roads so that the requirements of all people L_k, L_k + 1, \ldots, R_k are satisfied, print Yes; otherwise, print No.

      Input

      The input is given from Standard Input in the following format:
      N M Q
      S_1 T_1
      S_2 T_2
      \vdots
      S_M T_M
      L_1 R_1
      L_2 R_2
      \vdots
      L_Q R_Q

      Output

      Print Q lines.
      The k-th line should contain Yes if there is a way to set the strengths of the roads so that the requirements of all people L_k, L_k + 1, \ldots, R_k are satisfied, and No otherwise.

      Constraints


      - 3 \le N \le 4 \times 10^5
      - 1 \le M \le 2 \times 10^5
      - 1 \le Q \le 2 \times 10^5
      - 1 \le S_i, T_i \le N
      - |S_i - T_i| > 1
      - (S_i, T_i) \neq (S_j, T_j)\,(i \neq j)
      - 1 \le L_k \le R_k \le M
      - All input values are integers.

      Sample Input 1

      5 4 2
      4 2
      1 3
      3 5
      2 4
      1 3
      2 4

      Sample Output 1

      Yes
      No

      For the first query, consider setting the strengths of roads 1, 2, 3, 4 to 1, -1, 1, -1, respectively.

      - Person 1 starts at town 4 w

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5 4 2\n4 2\n1 3\n3 5\n2 4\n1 3\n2 4",
              "Yes\nNo"
          ],
          [
              "7 6 3\n1 5\n2 4\n4 6\n7 1\n5 3\n1 6\n1 6\n4 4\n2 5",
              "No\nYes\nYes"
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
