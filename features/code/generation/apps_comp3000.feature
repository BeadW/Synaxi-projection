Feature: APPS/competition/3000 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Two great friends, Eddie John and Kris Cross, are attending the Brackets Are Perfection Conference. They wholeheartedly agree with the main message of the conference and they are delighted with all the new things they learn about brackets.

      One of these things is a bracket sequence. If you want to do a computation with $+$ and $\times $, you usually write it like so:\[ (2 \times (2 + 1 + 0 + 1) \times 1) + 3 + 2. \]

      The brackets are only used to group multiplications and additions together. This means that you can remove all the operators, as long as you remember that addition is used for numbers outside any parentheses! A bracket sequence can then be shortened to\[ (\; 2 \; ( \; 2 \; 1 \; 0 \; 1 \; ) \; 1 \; ) \; 3 \; 2. \]

      That is much better, because it saves on writing all those operators. Reading bracket sequences is easy, too. Suppose you have the following bracket sequence\[ 5 \; 2 \; (\; 3 \; 1 \; (\; 2 \; 2 \; ) \; ( \; 3 \; 3 \; ) \; 1 \; ). \]

      You start with addition, so this is the same as the following:\[ 5 + 2 + (\; 3 \; 1 \; (\; 2 \; 2 \; ) \; ( \; 3 \; 3 \; ) \; 1 \; ). \]

      You know the parentheses group a multiplication, so this is equal to\[ 5 + 2 + (3 \times 1 \times (\; 2 \; 2 \; ) \times ( \; 3 \; 3 \; ) \times 1). \]

      Then there is another level of parentheses: that groups an operation within a multiplication, so the operation must be addition.\[ 5 + 2 + (3 \times 1 \times (2 + 2 ) \times (3 + 3) \times 1 ) = 5 + 2 + (3 \times 1 \times 4 \times 6 \times 1) = 5+2 + 72 = 79. \]

      Since bracket sequences are so much easier than normal expressions with operators, it should be easy to evaluate some big ones. We will even allow you to write a program to do it for you.

      Note that $(\; )$ is not a valid bracket sequence, nor a subsequence of any valid bracket sequence.

      -----Input-----
       - One line containing a single integer $1\leq n\leq 3\cdot 10^5$.
       - One line consisting of $n$ tokens, each being either (, ), or an integer $0\leq x < 10^9+7$. It i
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
              "2\n2 3\n",
              "5\n"
          ],
          [
              "8\n( 2 ( 2 1 ) ) 3\n",
              "9\n"
          ],
          [
              "4\n( 12 3 )\n",
              "36\n"
          ],
          [
              "6\n( 2 ) ( 3 )\n",
              "5\n"
          ],
          [
              "6\n( ( 2 3 ) )\n",
              "5\n"
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
