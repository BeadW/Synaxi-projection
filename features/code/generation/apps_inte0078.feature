Feature: APPS/interview/78 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      The only difference between easy and hard versions is constraints.

      Polycarp loves to listen to music, so he never leaves the player, even on the way home from the university. Polycarp overcomes the distance from the university to the house in exactly $T$ minutes.

      In the player, Polycarp stores $n$ songs, each of which is characterized by two parameters: $t_i$ and $g_i$, where $t_i$ is the length of the song in minutes ($1 \le t_i \le 15$), $g_i$ is its genre ($1 \le g_i \le 3$).

      Polycarp wants to create such a playlist so that he can listen to music all the time on the way from the university to his home, and at the time of his arrival home, the playlist is over. Polycarp never interrupts songs and always listens to them from beginning to end. Thus, if he started listening to the $i$-th song, he would spend exactly $t_i$ minutes on its listening. Polycarp also does not like when two songs of the same genre play in a row (i.e. successively/adjacently) or when the songs in his playlist are repeated.

      Help Polycarpus count the number of different sequences of songs (their order matters), the total duration is exactly $T$, such that there are no two consecutive songs of the same genre in them and all the songs in the playlist are different.


      -----Input-----

      The first line of the input contains two integers $n$ and $T$ ($1 \le n \le 15, 1 \le T \le 225$) — the number of songs in the player and the required total duration, respectively.

      Next, the $n$ lines contain descriptions of songs: the $i$-th line contains two integers $t_i$ and $g_i$ ($1 \le t_i \le 15, 1 \le g_i \le 3$) — the duration of the $i$-th song and its genre, respectively.


      -----Output-----

      Output one integer — the number of different sequences of songs, the total length of exactly $T$, such that there are no two consecutive songs of the same genre in them and all the songs in the playlist are different. Since the answer may be huge, output it modulo $10^9 + 7$ (that is, the remainder when dividing
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
              "3 3\n1 1\n1 2\n1 3\n",
              "6\n"
          ],
          [
              "3 3\n1 1\n1 1\n1 3\n",
              "2\n"
          ],
          [
              "4 10\n5 3\n2 1\n3 2\n5 1\n",
              "10\n"
          ],
          [
              "1 1\n1 1\n",
              "1\n"
          ],
          [
              "1 1\n1 3\n",
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
