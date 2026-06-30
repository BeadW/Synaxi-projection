Feature: LiveCodeBench/atcoder/hard — Random Walk on Tree
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is a tree with N \times M + 1 vertices numbered 0, 1, \dots, N \times M. The i-th edge (1 \leq i \leq N \times M) connects vertices i and \max(i - N, 0).
      Vertex 0 is painted. The other vertices are unpainted.
      Takahashi is at vertex 0. As long as there exists an unpainted vertex, he performs the following operation:

      - He chooses one of the vertices adjacent to his current vertex uniformly at random (all choices are independent) and moves to that vertex. Then, if the vertex he is on is unpainted, he paints it.

      Find the expected number of times he performs the operation, modulo 998244353.

      What is the expected value modulo 998244353?

      It can be proved that the sought expected value is always rational. Under the constraints of this problem, when that value is expressed as an irreducible fraction \frac{P}{Q}, it can also be proved that Q \not\equiv 0 \pmod{998244353}. Then, there uniquely exists an integer R such that R \times Q \equiv P \pmod{998244353}, 0 \leq R \lt 998244353. Report this R.

      Input

      The input is given from Standard Input in the following format:
      N M

      Output

      Print the expected number of times he performs the operation, modulo 998244353.

      Constraints


      - 1 \leq N \leq 2 \times 10^5
      - 1 \leq M \leq 2 \times 10^5
      - N and M are integers.

      Sample Input 1

      2 2

      Sample Output 1

      20

      For example, Takahashi could behave as follows.

      - Moves to vertex 1 and paints it. This action is chosen with probability \frac{1}{2}.
      - Moves to vertex 0. This action is chosen with probability \frac{1}{2}.
      - Moves to vertex 1. This action is chosen with probability \frac{1}{2}.
      - Moves to vertex 3 and paints it. This action is chosen with probability \frac{1}{2}.
      - Moves to vertex 1. This action is chosen with probability 1.
      - Moves to vertex 0. This action is chosen with probability \frac{1}{2}.
      - Moves to vertex 2 and paints it. This action is chosen with probability \frac{1}{2}.
      - Moves to vertex 4 and paints it. This action is chosen with probability \frac{1}{2

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "2 2",
              "20"
          ],
          [
              "123456 185185",
              "69292914"
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
