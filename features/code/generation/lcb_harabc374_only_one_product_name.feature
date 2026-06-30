Feature: LiveCodeBench/atcoder/hard — Only One Product Name
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      All KEYENCE product names consist of two uppercase English letters.
      They have already used N product names, the i-th of which (1\leq i\leq N) is S_i.
      Once a product name is used, it cannot be reused, so they decided to create an NG (Not Good) list to quickly identify previously used product names.
      The NG list must satisfy the following conditions.

      - It consists of one or more strings, each consisting of uppercase English letters.
      - For each already used product name, there exists at least one string in the list that contains the name as a (contiguous) substring.
      - None of the strings in the list contain any length-2 (contiguous) substring that is not an already used product name.

      Find the minimum possible number of strings in the NG list.

      Input

      The input is given from Standard Input in the following format:
      N
      S_1
      S_2
      \vdots
      S_N

      Output

      Print the minimum possible number of strings in the NG list.

      Constraints


      - 1\leq N\leq 26^2
      - N is an integer.
      - Each S_i is a string of length 2 consisting of uppercase English letters.
      - All S_1,S_2,\ldots,S_N are distinct.

      Sample Input 1

      7
      AB
      BC
      CA
      CD
      DE
      DF
      XX

      Sample Output 1

      3

      One NG list satisfying the conditions is the one consisting of the following three strings:

      - CABCDE
      - DF
      - XX

      This has three strings, and there is no NG list satisfying the conditions with 2 or fewer strings, so print 3.

      Sample Input 2

      5
      AC
      BC
      CD
      DE
      DF

      Sample Output 2

      2

      One NG list satisfying the conditions is the one consisting of the following two strings:

      - ACDE
      - BCDF

      Note that each used product name may appear in multiple strings in the NG list or multiple times within the same string.

      Sample Input 3

      6
      AB
      AC
      CB
      AD
      DB
      BA

      Sample Output 3

      1

      For example, an NG list consisting only of ABACBADB satisfies the conditions.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "7\nAB\nBC\nCA\nCD\nDE\nDF\nXX\n",
              "3\n"
          ],
          [
              "5\nAC\nBC\nCD\nDE\nDF\n",
              "2\n"
          ],
          [
              "6\nAB\nAC\nCB\nAD\nDB\nBA\n",
              "1\n"
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
              assert r.stdout.strip() == expected.strip(), (
                  f"Case {i}: expected {expected!r}, got {r.stdout!r}"
              )

      """

  Scenario: Agent solves the LiveCodeBench problem so all tests pass
    Given an agent is tasked with reading problem.txt and implementing solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
