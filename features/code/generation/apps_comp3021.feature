Feature: APPS/competition/3021 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      We all know how to alphabetize a list of distinct words when you know the alphabet: One word may be a prefix of another longer word, in which case the shorter word always comes before the longer word. With any other two words there must be a first place in the words where their letters differ. Then the order of the words is determined by the lexicographical order of these first differing letters.

      How about the reverse problem: Can you find the lexicographic order of the alphabet from an ordered list of words? Suppose an alphabet exists where the following list of word strings is given in lexicographical order:

      cab
      cda
      ccc
      badca

      It is clear that c comes before b in the underlying alphabet because cab comes before badca. Similarly, we know a comes before d, because cab < cda, a comes before c because cab < ccc, and d comes before c because cda < ccc. The only ordering of the 4 alphabet characters that is possible is adcb.

      However, it may be that a list contains inconsistencies that make it impossible to be ordered under any proposed alphabet. For example, in the following list it must be that a comes before b in the alphabet since abc < bca, yet it also must be that b comes before a in the alphabet since bca < aca.

      abc
      bca
      cab
      aca

      Finally, some lists may not provide enough clues to derive a unique alphabet order, such as the following:

      dea
      cfb

      In this list, d comes before c but we don’t know about the relative positions of any of the other letters, so we are unable to uniquely discern the order of the alphabet characters.

      -----Input-----
      The first line of input will contain $L$ and $N$, separated by a space, where $L$ is a lowercase character $\texttt{b} \le L \le \texttt{z}$ representing the highest character in the English alphabet that appears in the derived alphabet, and $N$ is an integer $1 \leq N \leq 1000$ that is equal to the number of strings in the list. Each of the next $N$ lines will contain a single nonempty string of length at most $1000$, consi
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
              "d 4\ncab\ncda\nccc\nbadca\n",
              "adcb\n"
          ],
          [
              "c 4\nabc\nbca\ncab\naca\n",
              "IMPOSSIBLE\n"
          ],
          [
              "f 2\ndea\ncfb\n",
              "AMBIGUOUS\n"
          ],
          [
              "e 5\nebbce\ndbe\nadcd\nbc\ncd\n",
              "edabc\n"
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
