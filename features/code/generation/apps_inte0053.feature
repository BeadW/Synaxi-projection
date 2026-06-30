Feature: APPS/interview/53 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      A string a of length m is called antipalindromic iff m is even, and for each i (1 ≤ i ≤ m) a_{i} ≠ a_{m} - i + 1.

      Ivan has a string s consisting of n lowercase Latin letters; n is even. He wants to form some string t that will be an antipalindromic permutation of s. Also Ivan has denoted the beauty of index i as b_{i}, and the beauty of t as the sum of b_{i} among all indices i such that s_{i} = t_{i}.

      Help Ivan to determine maximum possible beauty of t he can get.


      -----Input-----

      The first line contains one integer n (2 ≤ n ≤ 100, n is even) — the number of characters in s.

      The second line contains the string s itself. It consists of only lowercase Latin letters, and it is guaranteed that its letters can be reordered to form an antipalindromic string.

      The third line contains n integer numbers b_1, b_2, ..., b_{n} (1 ≤ b_{i} ≤ 100), where b_{i} is the beauty of index i.


      -----Output-----

      Print one number — the maximum possible beauty of t.


      -----Examples-----
      Input
      8
      abacabac
      1 1 1 1 1 1 1 1

      Output
      8

      Input
      8
      abaccaba
      1 2 3 4 5 6 7 8

      Output
      26

      Input
      8
      abacabca
      1 2 3 4 4 3 2 1

      Output
      17

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "8\nabacabac\n1 1 1 1 1 1 1 1\n",
              "8\n"
          ],
          [
              "8\nabaccaba\n1 2 3 4 5 6 7 8\n",
              "26\n"
          ],
          [
              "8\nabacabca\n1 2 3 4 4 3 2 1\n",
              "17\n"
          ],
          [
              "100\nbaaacbccbccaccaccaaabcabcabccacaabcbccbccabbabcbcbbaacacbacacacaacccbcbbbbacccababcbacacbacababcacbc\n28 28 36 36 9 53 7 54 66 73 63 30 55 53 54 74 60 2 34 36 72 56 13 63 99 4 44 54 29 75 9 68 80 49 74 94 42 22 43 4 41 88 87 44 85 76 20 5 5 36 50 90 78 63 84 93 47 33 64 60 11 67 70 7 14 45 48 88 12 95 65 53 37 15 49 50 47 57 15 84 96 18 63 23 93 14 85 26 55 58 8 49 54 94 3 10 61 24 68 1\n",
              "4382\n"
          ],
          [
              "100\ncccccaacccbaaababacbbacbbbcbccaccaccbcccbbaabababcacbccaacacaababacbcbcccabcacbccccbccaaabcabcaaabcc\n95 91 11 97 2 16 42 33 22 1 26 52 47 45 96 96 53 99 38 61 27 53 6 13 12 77 76 19 69 60 88 85 61 29 81 65 52 47 23 12 93 76 46 30 71 11 96 3 80 79 71 93 17 57 57 20 71 75 58 41 34 99 54 27 88 12 37 37 3 73 72 25 28 35 35 55 37 56 61 1 11 59 89 52 81 13 13 53 7 83 90 61 36 58 77 4 41 33 13 84\n",
              "4494\n"
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
