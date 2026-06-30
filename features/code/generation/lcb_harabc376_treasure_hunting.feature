Feature: LiveCodeBench/atcoder/hard — Treasure Hunting
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is a rooted tree with N + 1 vertices numbered from 0 to N. Vertex 0 is the root, and the parent of vertex i is vertex p_i.
      One of the vertices among vertex 1, vertex 2, ..., vertex N hides a treasure. The probability that the treasure is at vertex i is \frac{a_i}{\sum_{j=1}^N a_j}.
      Also, each vertex is in one of the two states: "searched" and "unsearched". Initially, vertex 0 is searched, and all other vertices are unsearched.
      Until the vertex containing the treasure becomes searched, you perform the following operation:

      - Choose an unsearched vertex whose parent is searched, and mark it as searched.

      Find the expected number of operations required when you act to minimize the expected number of operations, modulo 998244353.
      You are given T test cases; solve each of them.

      How to find an expected value modulo 998244353

      It can be proved that the expected value is always a rational number. Under the constraints of this problem, it can also be proved that when the expected value is expressed as an irreducible fraction \frac{P}{Q}, we have Q \not\equiv 0 \pmod{998244353}. In this case, there is a unique integer R satisfying R \times Q \equiv P \pmod{998244353},\ 0 \leq R < 998244353. Report this R.

      Input

      The input is given from Standard Input in the following format. Here, \mathrm{case}_i denotes the i-th test case.
      T
      \mathrm{case}_1
      \mathrm{case}_2
      \vdots
      \mathrm{case}_T

      Each test case is given in the following format:
      N
      p_1 p_2 \dots p_N
      a_1 a_2 \dots a_N

      Output

      Print T lines. The i-th line should contain the answer for the i-th test case.

      Constraints


      - 1 \leq T \leq 2 \times 10^5
      - 1 \leq N \leq 2 \times 10^5
      - 0 \leq p_i < i
      - 1 \leq a_i
      - \sum_{i=1}^N a_i \leq 10^8
      - The sum of N over all test cases is at most 2 \times 10^5.
      - All input values are integers.

      Sample Input 1

      3
      3
      0 0 1
      1 2 3
      5
      0 1 0 0 0
      8 6 5 1 7
      10
      0 1 1 3 3 1 4 7 5 4
      43 39 79 48 92 90 76 30 16 30

      Sample Output 1

      166374061
      295776107
      680203339

      In the first t

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\n3\n0 0 1\n1 2 3\n5\n0 1 0 0 0\n8 6 5 1 7\n10\n0 1 1 3 3 1 4 7 5 4\n43 39 79 48 92 90 76 30 16 30\n",
              "166374061\n295776107\n680203339\n"
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
