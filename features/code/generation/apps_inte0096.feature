Feature: APPS/interview/96 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      At first, let's define function $f(x)$ as follows: $$ \begin{matrix} f(x) & = & \left\{ \begin{matrix} \frac{x}{2} & \mbox{if } x \text{ is even} \\ x - 1 & \mbox{otherwise } \end{matrix} \right. \end{matrix} $$

      We can see that if we choose some value $v$ and will apply function $f$ to it, then apply $f$ to $f(v)$, and so on, we'll eventually get $1$. Let's write down all values we get in this process in a list and denote this list as $path(v)$. For example, $path(1) = [1]$, $path(15) = [15, 14, 7, 6, 3, 2, 1]$, $path(32) = [32, 16, 8, 4, 2, 1]$.

      Let's write all lists $path(x)$ for every $x$ from $1$ to $n$. The question is next: what is the maximum value $y$ such that $y$ is contained in at least $k$ different lists $path(x)$?

      Formally speaking, you need to find maximum $y$ such that $\left| \{ x ~|~ 1 \le x \le n, y \in path(x) \} \right| \ge k$.


      -----Input-----

      The first line contains two integers $n$ and $k$ ($1 \le k \le n \le 10^{18}$).


      -----Output-----

      Print the only integer — the maximum value that is contained in at least $k$ paths.


      -----Examples-----
      Input
      11 3

      Output
      5

      Input
      11 6

      Output
      4

      Input
      20 20

      Output
      1

      Input
      14 5

      Output
      6

      Input
      1000000 100

      Output
      31248



      -----Note-----

      In the first example, the answer is $5$, since $5$ occurs in $path(5)$, $path(10)$ and $path(11)$.

      In the second example, the answer is $4$, since $4$ occurs in $path(4)$, $path(5)$, $path(8)$, $path(9)$, $path(10)$ and $path(11)$.

      In the third example $n = k$, so the answer is $1$, since $1$ is the only number occuring in all paths for integers from $1$ to $20$.

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "11 3\n",
              "5\n"
          ],
          [
              "11 6\n",
              "4\n"
          ],
          [
              "20 20\n",
              "1\n"
          ],
          [
              "14 5\n",
              "6\n"
          ],
          [
              "1000000 100\n",
              "31248\n"
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
