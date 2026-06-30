Feature: APPS/interview/7 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Anton likes to listen to fairy tales, especially when Danik, Anton's best friend, tells them. Right now Danik tells Anton a fairy tale:

      "Once upon a time, there lived an emperor. He was very rich and had much grain. One day he ordered to build a huge barn to put there all his grain. Best builders were building that barn for three days and three nights. But they overlooked and there remained a little hole in the barn, from which every day sparrows came through. Here flew a sparrow, took a grain and flew away..."

      More formally, the following takes place in the fairy tale. At the beginning of the first day the barn with the capacity of n grains was full. Then, every day (starting with the first day) the following happens:  m grains are brought to the barn. If m grains doesn't fit to the barn, the barn becomes full and the grains that doesn't fit are brought back (in this problem we can assume that the grains that doesn't fit to the barn are not taken into account).  Sparrows come and eat grain. In the i-th day i sparrows come, that is on the first day one sparrow come, on the second day two sparrows come and so on. Every sparrow eats one grain. If the barn is empty, a sparrow eats nothing. 

      Anton is tired of listening how Danik describes every sparrow that eats grain from the barn. Anton doesn't know when the fairy tale ends, so he asked you to determine, by the end of which day the barn will become empty for the first time. Help Anton and write a program that will determine the number of that day!


      -----Input-----

      The only line of the input contains two integers n and m (1 ≤ n, m ≤ 10^18) — the capacity of the barn and the number of grains that are brought every day.


      -----Output-----

      Output one integer — the number of the day when the barn will become empty for the first time. Days are numbered starting with one.


      -----Examples-----
      Input
      5 2

      Output
      4

      Input
      8 1

      Output
      5



      -----Note-----

      In the first sample the capacity of the barn is five grains and two 
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
              "5 2\n",
              "4\n"
          ],
          [
              "8 1\n",
              "5\n"
          ],
          [
              "32 5\n",
              "12\n"
          ],
          [
              "1024 1024\n",
              "1024\n"
          ],
          [
              "58044 52909\n",
              "53010\n"
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
