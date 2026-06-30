Feature: LiveCodeBench/atcoder/hard — 1122 Substring
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      A sequence X = (X_1, X_2, \ldots) of positive integers (possibly empty) is called a 1122 sequence if and only if it satisfies all of the following three conditions: (The definition of a 1122 sequence is the same as in Problem F.)

      - \lvert X \rvert is even. Here, \lvert X \rvert denotes the length of X.
      - For each integer i satisfying 1\leq i\leq \frac{|X|}{2}, X_{2i-1} and X_{2i} are equal.
      - Each positive integer appears in X either not at all or exactly twice. That is, every positive integer contained in X appears exactly twice in X.

      Given a sequence A = (A_1, A_2, \ldots, A_N) of length N consisting of positive integers, print the maximum length of a (contiguous) subarray of A that is a 1122 sequence.

      Input

      The input is given from Standard Input in the following format:
      N
      A_1 A_2 \ldots A_N

      Output

      Print the maximum length of a (contiguous) subarray of A that is a 1122 sequence.

      Constraints


      - 1\leq N \leq 2 \times 10^5
      - 1\leq A_i \leq N
      - All input values are integers.

      Sample Input 1

      8
      2 3 1 1 2 2 1 1

      Sample Output 1

      4

      For example, taking the subarray from the 3-rd to 6-th elements of A, we get (1, 1, 2, 2), which is a 1122 sequence of length 4.
      There is no longer (contiguous) subarray that satisfies the conditions for a 1122 sequence, so the answer is 4.

      Sample Input 2

      3
      1 2 2

      Sample Output 2

      2

      Sample Input 3

      1
      1

      Sample Output 3

      0

      Note that a sequence of length 0 also satisfies the conditions for a 1122 sequence.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "8\n2 3 1 1 2 2 1 1",
              "4"
          ],
          [
              "3\n1 2 2",
              "2"
          ],
          [
              "1\n1",
              "0"
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
