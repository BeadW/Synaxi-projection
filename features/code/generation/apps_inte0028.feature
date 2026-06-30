Feature: APPS/interview/28 — competitive programming problem
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      The All-Berland National Olympiad in Informatics has just ended! Now Vladimir wants to upload the contest from the Olympiad as a gym to a popular Codehorses website.

      Unfortunately, the archive with Olympiad's data is a mess. For example, the files with tests are named arbitrary without any logic.

      Vladimir wants to rename the files with tests so that their names are distinct integers starting from 1 without any gaps, namely, "1", "2", ..., "n', where n is the total number of tests.

      Some of the files contain tests from statements (examples), while others contain regular tests. It is possible that there are no examples, and it is possible that all tests are examples. Vladimir wants to rename the files so that the examples are the first several tests, all all the next files contain regular tests only.

      The only operation Vladimir can perform is the "move" command. Vladimir wants to write a script file, each of the lines in which is "move file_1 file_2", that means that the file "file_1" is to be renamed to "file_2". If there is a file "file_2" at the moment of this line being run, then this file is to be rewritten. After the line "move file_1 file_2" the file "file_1" doesn't exist, but there is a file "file_2" with content equal to the content of "file_1" before the "move" command.

      Help Vladimir to write the script file with the minimum possible number of lines so that after this script is run:  all examples are the first several tests having filenames "1", "2", ..., "e", where e is the total number of examples;  all other files contain regular tests with filenames "e + 1", "e + 2", ..., "n", where n is the total number of all tests. 


      -----Input-----

      The first line contains single integer n (1 ≤ n ≤ 10^5) — the number of files with tests.

      n lines follow, each describing a file with test. Each line has a form of "name_i type_i", where "name_i" is the filename, and "type_i" equals "1", if the i-th file contains an example test, and "0" if it contains a regular te
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
              "5\n01 0\n2 1\n2extra 0\n3 1\n99 0\n",
              "4\nmove 3 1\nmove 01 5\nmove 2extra 4\nmove 99 3\n"
          ],
          [
              "2\n1 0\n2 1\n",
              "3\nmove 1 07x45l\nmove 2 1\nmove 07x45l 2\n"
          ],
          [
              "5\n1 0\n11 1\n111 0\n1111 1\n11111 0\n",
              "5\nmove 1 5\nmove 11 1\nmove 1111 2\nmove 111 4\nmove 11111 3\n"
          ],
          [
              "4\nir7oz8 1\nvj4v5t 1\nkwkahb 1\nj5s8o1 0\n",
              "4\nmove ir7oz8 1\nmove vj4v5t 2\nmove kwkahb 3\nmove j5s8o1 4\n"
          ],
          [
              "4\n3 1\n1o0bp2 0\n9tn379 0\nv04v6j 1\n",
              "4\nmove 3 1\nmove v04v6j 2\nmove 1o0bp2 4\nmove 9tn379 3\n"
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
