Feature: LiveCodeBench/codeforces/hard — D. Yarik and Musical Notes
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Yarik is a big fan of many kinds of music. But Yarik loves not only listening to music but also writing it. He likes electronic music most of all, so he has created his own system of music notes, which, in his opinion, is best for it.

      Since Yarik also likes informatics, in his system notes are denoted by integers of $2^k$, where $k \ge 1$ — a positive integer. But, as you know, you can't use just notes to write music, so Yarik uses combinations of two notes. The combination of two notes $(a, b)$, where $a = 2^k$ and $b = 2^l$, he denotes by the integer $a^b$.

      For example, if $a = 8 = 2^3$, $b = 4 = 2^2$, then the combination $(a, b)$ is denoted by the integer $a^b = 8^4 = 4096$. Note that different combinations can have the same notation, e.g., the combination $(64, 2)$ is also denoted by the integer $4096 = 64^2$.

      Yarik has already chosen $n$ notes that he wants to use in his new melody. However, since their integers can be very large, he has written them down as an array $a$ of length $n$, then the note $i$ is $b_i = 2^{a_i}$. The integers in array $a$ can be repeated.

      The melody will consist of several combinations of two notes. Yarik was wondering how many pairs of notes $b_i, b_j$ $(i < j)$ exist such that the combination $(b_i, b_j)$ is equal to the combination $(b_j, b_i)$. In other words, he wants to count the number of pairs $(i, j)$ $(i < j)$ such that $b_i^{b_j} = b_j^{b_i}$. Help him find the number of such pairs.

      Input

      The first line of the input contains one integer $t$ ($1 \le t \le 10^4$) — the number of test cases.

      The first line of each test case contains one integer $n$ ($1 \leq n \leq 2 \cdot 10^5$) — the length of the arrays.

      The next line contains $n$ integers $a_1, a_2, \dots, a_n$ ($1 \leq a_i \leq 10^9$) — array $a$.

      It is guaranteed that the sum of $n$ over all test cases does not exceed $2 \cdot 10^5$.

      Output

      For each test case, output the number of pairs that satisfy the given condition.Sample Input 1:
      5

      1

      2

      4

      3 1 3 2

      2

      1

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5\n1\n2\n4\n3 1 3 2\n2\n1000 1000\n3\n1 1 1\n19\n2 4 1 6 2 8 5 4 2 10 5 10 8 7 4 3 2 6 10\n",
              "0\n2\n1\n3\n19\n"
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
              assert r.stdout.strip() == str(expected).strip(), (
                  f"Case {i}: expected {expected!r}, got {r.stdout!r}"
              )

      """

  Scenario: Agent solves the LiveCodeBench problem so all tests pass
    Given an agent is tasked with reading problem.txt and implementing solution.py to read from stdin and write the correct answer to stdout so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
