Feature: APPS/competition/3048 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      The Kanto region has $N$ junctions and $N - 1$ bidirectional roads. Junctions are numbered from $1$ to $N$, inclusive. All roads have the same length and each of them connects two different junctions.

      At any moment, a Pokenom can appear in any of these junctions.

      To become the best Pokenom trainer, like no one ever was, Bash is studying the behavior of the Pokenom in Kanto region. Bash has found that, when trying to capture a Pokenom at junction $u$, the Pokenom can run away to junction $v$, iff the optimal path between $u$ and $v$ has length exactly $2$.

      More formally, a path of length $K$ from junction $s$ to junction $t$ is an ordered sequence of junctions $v_{0} \rightarrow v_{1} \rightarrow v_{2} \rightarrow \cdots \rightarrow v_{K}$, where $v_{0} = s, v_{K} = t$ and for each valid index $i$, $v_{i}$ and $v_{i+1}$ are connected directly by some road. A path is called optimal iff there is no shorter path with the same starting and ending junctions. Two paths $v_{0} \rightarrow v_{1} \rightarrow \cdots \rightarrow v_{k}$ and $w_{0} \rightarrow w_{1} \rightarrow \cdots w_{l}$ are different iff either $k \neq l$ or there exist some valid $i$ such that $v_{i} \neq w_{i}$.

      A Pokenom can use an optimal path of length exactly $2$. Help Bash count the number of such paths.

      -----Input-----
       - The first line contains one integer $N$ $(1 \leq N \leq 3 \cdot 10^{5})$ — the number of junctions.
       - Each of the rest $N - 1$ lines contains two integers $u$ and $v$ $(1 \leq u, v \leq N, u \neq v)$ — two endpoints of a single road.

      -----Output-----
       - The only line contains exactly one integer — the number of optimal paths of length $2$.

      -----Explanation for the first example-----
       - There are two optimal paths of length $2$: $(2 \rightarrow 1 \rightarrow 3)$ and $(3 \rightarrow 1 \rightarrow 2)$.
       - The path $(1 \rightarrow 2 \rightarrow 1)$ is a valid path of length $2$ from $1$ to $1$ but it is not optimal since there is a path of length $0$ from $1$ to $1$.

      -----Examp
      ...(truncated)

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "3\n1 2\n1 3\n",
              "2\n"
          ],
          [
              "5\n2 1\n1 5\n3 1\n4 3\n",
              "8\n"
          ],
          [
              "10\n1 2\n2 3\n2 4\n1 5\n3 6\n2 7\n7 8\n5 9\n5 10\n",
              "24\n"
          ],
          [
              "8\n1 2\n2 3\n3 4\n4 5\n5 6\n6 1\n2 1\n",
              "12\n"
          ]
      ]


      def test_apps():
          for i, (inp, expected) in enumerate(TEST_CASES):
              r = subprocess.run(
                  [sys.executable, "solution.py"],
                  input=inp,
                  capture_output=True,
                  text=True,
                  timeout=10,
              )
              assert r.returncode == 0, f"Case {i}: runtime error\n{r.stderr[:400]}"
              assert r.stdout.strip() == str(expected).strip(), (
                  f"Case {i}: expected {expected!r}, got {r.stdout!r}"
              )

      """

  Scenario: Agent solves the APPS problem so all tests pass
    Given an agent is tasked with reading problem.txt and implementing solution.py to read from stdin and write the correct answer to stdout so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
