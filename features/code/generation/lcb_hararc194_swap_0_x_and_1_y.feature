Feature: LiveCodeBench/atcoder/hard — Swap 0^X and 1^Y
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given two strings S and T, each of length N and consisting of 0 and 1, as well as two positive integers X and Y. For i = 1, 2, \ldots, N, let S_i denote the i-th character of S.
      Determine whether it is possible to make S identical to T by repeatedly performing Operations A and B below any number of times (possibly zero) in any order:

      - 
      (Operation A) Choose an integer i satisfying 1 \leq i \leq N-(X+Y)+1, S_{i} = S_{i+1} = \cdots = S_{i+X-1} = 0, and S_{i+X} = S_{i+X+1} = \cdots = S_{i+X+Y-1} = 1, then change each of S_{i}, S_{i+1}, \ldots, S_{i+Y-1} to 1 and each of S_{i+Y}, S_{i+Y+1}, \ldots, S_{i+Y+X-1} to 0.

      - 
      (Operation B) Choose an integer i satisfying 1 \leq i \leq N-(X+Y)+1, S_{i} = S_{i+1} = \cdots = S_{i+Y-1} = 1, and S_{i+Y} = S_{i+Y+1} = \cdots = S_{i+Y+X-1} = 0, then change each of S_{i}, S_{i+1}, \ldots, S_{i+X-1} to 0 and each of S_{i+X}, S_{i+X+1}, \ldots, S_{i+X+Y-1} to 1.

      Input

      The input is given from Standard Input in the following format:
      N X Y
      S
      T

      Output

      If it is possible to make S identical to T, print Yes; otherwise, print No.

      Constraints


      - 1 \leq N \leq 5 \times 10^5
      - 1 \leq X, Y \leq N
      - S and T are strings of length N consisting of 0 and 1.
      - All input values are integers.

      Sample Input 1

      9 2 1
      000111001
      011000011

      Sample Output 1

      Yes

      The following procedure can transform S into T:

      - First, perform Operation A with i = 2. Now, S = 010011001.
      - Next, perform Operation B with i = 6. Now, S = 010010011.
      - Finally, perform Operation A with i = 3. Now, S = 011000011.

      Thus, print Yes.

      Sample Input 2

      1 1 1
      0
      1

      Sample Output 2

      No

      It is impossible to make S identical to T. Thus, print No.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "9 2 1\n000111001\n011000011",
              "Yes"
          ],
          [
              "1 1 1\n0\n1",
              "No"
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
