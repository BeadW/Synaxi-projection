Feature: APPS/competition/3006 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      To store DNA sequences your company has developed a LongLongString class that can store strings with up to ten billion characters. The class supports two basic operations: 
       - Ins($p$, $c$): Insert the character $c$ at position $p$.
       - Del($p$): Delete the character at position $p$.

      A DNA editing program is written as a series of Ins and Del operations. Your job is to write a program that compare two DNA editing programs and determine if they are identical, i.e., when applied to any sufficiently long string, whether the end result is the same.

      For example:
       - Del(1) Del(2) and Del(3) Del(1) are identical.
       - Del(2) Del(1) and Del(1) Del(2) are different.
       - An empty sequence and Ins(1, $X$) Del(1) are identical.
       - Ins(14, $B$) Ins(14, $A$) and Ins(14, $A$) Ins(15, $B$) are identical.
       - Ins(14, $A$) Ins(15, $B$) and Ins(14, $B$) Ins(15, $A$) are different.

      -----Input-----
      Input will consist of the descriptions of two DNA editing programs.

      Each program will consist of some number of operations (between $0$ and $2000$). Each operation will be given on its own line. The first character of the line will be D for a Del operation, I for an Ins operation, or E marking the end of the program.

      A Del operation will have the D character, followed by a space, and then a single integer between $1$ and $10^{10}$, indicating the character position to delete. All characters after this deleted character will be shifted one position lower.

      An Ins operation will have the I character, followed by a space, and then a single integer between $1$ and $10^{10}$, indicating the location to insert the new character; all pre-existing characters with this index and higher will be shifted one position higher. Following this integer will be another space and then an uppercase alphabetic character that is the character to insert.

      -----Output-----
      If the two programs are identical, print “0” on a single line (without quotation marks). Otherwise, print “1” on a single line (without quotation
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
              "D 1\nD 2\nE\nD 3\nD 1\nE\n",
              "0\n"
          ],
          [
              "D 2\nD 1\nE\nD 1\nD 2\nE\n",
              "1\n"
          ],
          [
              "I 1 X\nD 1\nE\nE\n",
              "0\n"
          ],
          [
              "I 14 B\nI 14 A\nE\nI 14 A\nI 15 B\nE\n",
              "0\n"
          ],
          [
              "I 14 A\nI 15 B\nE\nI 14 B\nI 15 A\nE\n",
              "1\n"
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
