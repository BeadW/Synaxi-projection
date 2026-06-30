Feature: LiveCodeBench/atcoder/hard — Sleep Log
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Takahashi keeps a sleep log.
      The log is represented as an odd-length sequence A=(A _ 1(=0), A _ 2,\ldots,A _ N), where odd-numbered elements represent times he got up, and even-numbered elements represent times he went to bed.
      More formally, he had the following sleep sessions after starting the sleep log.

      - For every integer i such that 1\leq i\leq\dfrac{N-1}2, he fell asleep exactly A _ {2i} minutes after starting the sleep log and woke up exactly A _ {2i+1} minutes after starting the sleep log.
      - He did not fall asleep or wake up at any other time.

      Answer the following Q questions.
      For the i-th question, you are given a pair of integers (l _ i,r _ i) such that 0\leq l _ i\leq r _ i\leq A _ N.

      - What is the total number of minutes for which Takahashi was asleep during the r _ i-l _ i minutes from exactly l _ i minutes to r _ i minutes after starting the sleep log?

      Input

      The input is given from Standard Input in the following format:
      N
      A _ 1 A _ 2 \ldots A _ N
      Q
      l _ 1 r _ 1
      l _ 2 r _ 2
      \vdots
      l _ Q r _ Q

      Output

      Print the answer in Q lines.
      The i-th line should contain an integer answering to the i-th question.

      Constraints


      - 3\leq N\lt2\times10^5
      - N is odd.
      - 0=A _ 1\lt A _ 2\lt\cdots\lt A _ N\leq10^9
      - 1\leq Q\leq2\times10^5
      - 0\leq l _ i\leq r _ i\leq A _ N\ (1\leq i\leq Q)
      - All input values are integers.

      Sample Input 1

      7
      0 240 720 1320 1440 1800 2160
      3
      480 1920
      720 1200
      0 2160

      Sample Output 1

      480
      0
      960

      Takahashi slept as shown in the following figure.

      The answers to each question are as follows.

      - Between 480 minutes and 1920 minutes after starting the sleep log, Takahashi slept from 480 minutes to 720 minutes, from 1320 minutes to 1440 minutes, and from 1800 minutes to 1920 minutes in 3 sleep sessions. The total sleep time is 240+120+120=480 minutes.
      - Between 720 minutes and 1200 minutes after starting the sleep log, Takahashi did not sleep. The total sleep time is 0 minutes.
      - Between 0 minutes and 2160 minutes after starti

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "7\n0 240 720 1320 1440 1800 2160\n3\n480 1920\n720 1200\n0 2160\n",
              "480\n0\n960\n"
          ],
          [
              "21\n0 20 62 192 284 310 323 324 352 374 409 452 486 512 523 594 677 814 838 946 1000\n10\n77 721\n255 541\n478 970\n369 466\n343 541\n42 165\n16 618\n222 592\n730 983\n338 747\n",
              "296\n150\n150\n49\n89\n20\n279\n183\n61\n177\n"
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
