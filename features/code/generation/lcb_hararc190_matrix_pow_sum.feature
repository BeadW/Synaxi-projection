Feature: LiveCodeBench/atcoder/hard — Matrix Pow Sum
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a prime number p and an N \times N matrix A = (A_{i,j}) (1\leq i,j\leq N). Each element of A is an integer between 0 and p-1, inclusive.
      Consider a matrix B obtained by replacing each zero in A with an integer between 1 and p-1, inclusive. There are (p-1)^K such matrices B, where K is the number of zeros in A.
      Find each element, modulo p, of the sum of B^p over all possible B.

      Input

      The input is given from Standard Input in the following format:
      N p
      A_{1,1} \cdots A_{1,N}
      \vdots
      A_{N,1} \cdots A_{N,N}

      Output

      Print N lines.
      The i-th line should contain, in the order j=1,\ldots,N, the (i,j) element of the sum, modulo p, of B^p over all possible B, separated by spaces.

      Constraints


      - 1 \leq N \leq 100
      - p is a prime such that 1 \leq p \leq 10^9.
      - 0 \leq A_{i,j} \leq p-1
      - All input values are integers.

      Sample Input 1

      2 3
      0 1
      0 2

      Sample Output 1

      0 2
      1 2

      B^p for all possible B are as follows:

      - \begin{pmatrix}1&1 \\ 1&2\end{pmatrix}^3=\begin{pmatrix}5&8 \\ 8&13\end{pmatrix}
      - \begin{pmatrix}1&1 \\ 2&2\end{pmatrix}^3=\begin{pmatrix}9&9 \\ 18&18\end{pmatrix}
      - \begin{pmatrix}2&1 \\ 1&2\end{pmatrix}^3=\begin{pmatrix}14&13 \\ 13&14\end{pmatrix}
      - \begin{pmatrix}2&1 \\ 2&2\end{pmatrix}^3=\begin{pmatrix}20&14 \\ 28&20\end{pmatrix}

      Print each element, modulo p=3, of their sum \begin{pmatrix}48&44 \\ 67&65\end{pmatrix}.

      Sample Input 2

      3 2
      1 0 0
      0 1 0
      0 0 1

      Sample Output 2

      1 1 1
      1 1 1
      1 1 1

      B^p for all possible B are as follows:

      - \begin{pmatrix}1&1&1 \\ 1&1&1 \\ 1&1&1\end{pmatrix}^2=\begin{pmatrix}3&3&3\\3&3&3\\3&3&3\end{pmatrix}

      Print each element, modulo p=2, of their sum \begin{pmatrix}3&3&3\\3&3&3\\3&3&3\end{pmatrix}.

      Sample Input 3

      4 13
      0 1 2 0
      3 4 0 5
      0 6 0 7
      8 9 0 0

      Sample Output 3

      8 0 6 5
      11 1 8 5
      8 0 4 12
      8 0 1 9

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "2 3\n0 1\n0 2",
              "0 2\n1 2"
          ],
          [
              "3 2\n1 0 0\n0 1 0\n0 0 1",
              "1 1 1\n1 1 1\n1 1 1"
          ],
          [
              "4 13\n0 1 2 0\n3 4 0 5\n0 6 0 7\n8 9 0 0",
              "8 0 6 5\n11 1 8 5\n8 0 4 12\n8 0 1 9"
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
