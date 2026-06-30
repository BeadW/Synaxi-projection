Feature: LiveCodeBench/atcoder/hard — Best Performances
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      We have a sequence A=(A_1,A_2,\dots,A_N) of length N.  Initially, all the terms are 0.
      Using an integer K given in the input, we define a function f(A) as follows:

      - Let B be the sequence obtained by sorting A in descending order (so that it becomes monotonically non-increasing).
      - Then, let f(A)=B_1 + B_2 + \dots + B_K.

      We consider applying Q updates on this sequence.
      Apply the following operation on the sequence A for i=1,2,\dots,Q in this order, and print the value f(A) at that point after each update.  

      - Change A_{X_i} to Y_i.

      Input

      The input is given from Standard Input in the following format:
      N K Q
      X_1 Y_1
      X_2 Y_2
      \vdots
      X_Q Y_Q

      Output

      Print Q lines in total.  The i-th line should contain the value f(A) as an integer when the i-th update has ended.

      Constraints


      - All input values are integers.
      - 1 \le K \le N \le 5 \times 10^5
      - 1 \le Q \le 5 \times 10^5
      - 1 \le X_i \le N
      - 0 \le Y_i \le 10^9

      Sample Input 1

      4 2 10
      1 5
      2 1
      3 3
      4 2
      2 10
      1 0
      4 0
      3 1
      2 0
      3 0

      Sample Output 1

      5
      6
      8
      8
      15
      13
      13
      11
      1
      0

      In this input, N=4 and K=2.  Q=10 updates are applied.

      - The 1-st update makes A=(5, 0,0,0).  Now, f(A)=5.
      - The 2-nd update makes A=(5, 1,0,0).  Now, f(A)=6.
      - The 3-rd update makes A=(5, 1,3,0).  Now, f(A)=8.
      - The 4-th update makes A=(5, 1,3,2).  Now, f(A)=8.
      - The 5-th update makes A=(5,10,3,2).  Now, f(A)=15.
      - The 6-th update makes A=(0,10,3,2).  Now, f(A)=13.
      - The 7-th update makes A=(0,10,3,0).  Now, f(A)=13.
      - The 8-th update makes A=(0,10,1,0).  Now, f(A)=11.
      - The 9-th update makes A=(0, 0,1,0).  Now, f(A)=1.
      - The 10-th update makes A=(0, 0,0,0).  Now, f(A)=0.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "4 2 10\n1 5\n2 1\n3 3\n4 2\n2 10\n1 0\n4 0\n3 1\n2 0\n3 0\n",
              "5\n6\n8\n8\n15\n13\n13\n11\n1\n0\n"
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
