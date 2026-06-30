Feature: LiveCodeBench/atcoder/hard — Maximum Composition
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given N linear functions f_1, f_2, \ldots, f_N, where f_i(x) = A_i x + B_i.
      Find the maximum possible value of f_{p_1}(f_{p_2}(\ldots f_{p_K}(1) \ldots )) for a sequence p = (p_1, p_2, \ldots, p_K) of K distinct integers between 1 and N, inclusive.

      Input

      The input is given from Standard Input in the following format:
      N K
      A_1 B_1
      A_2 B_2
      \vdots
      A_N B_N

      Output

      Print the answer as an integer.

      Constraints


      - 1 \leq N \leq 2 \times 10^{5}
      - 1 \leq K \leq \text{min}(N,10)
      - 1 \leq A_i, B_i \leq 50 (1 \leq i \leq N)
      - All input values are integers.

      Sample Input 1

      3 2
      2 3
      1 5
      4 2

      Sample Output 1

      26

      Here are all possible p and the corresponding values of f_{p_1}(f_{p_2}(1)):

      - p= ( 1,2 ) : f_1(f_2(1))=15
      - p= ( 1,3 ) : f_1(f_3(1))=15
      - p= ( 2,1 ) : f_2(f_1(1))=10
      - p= ( 2,3 ) : f_2(f_3(1))=11
      - p= ( 3,1 ) : f_3(f_1(1))=22
      - p= ( 3,2 ) : f_3(f_2(1))=26

      Therefore, print 26.

      Sample Input 2

      10 3
      48 40
      34 22
      24 37
      45 40
      48 31
      49 44
      45 40
      44 6
      35 22
      39 28

      Sample Output 2

      216223

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 2\n2 3\n1 5\n4 2\n",
              "26\n"
          ],
          [
              "10 3\n48 40\n34 22\n24 37\n45 40\n48 31\n49 44\n45 40\n44 6\n35 22\n39 28\n",
              "216223\n"
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
