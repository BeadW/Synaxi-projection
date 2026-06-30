Feature: LiveCodeBench/atcoder/medium — Shift vs. CapsLock
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Your computer has a keyboard with three keys: 'a' key, Shift key, and Caps Lock key.  The Caps Lock key has a light on it.
      Initially, the light on the Caps Lock key is off, and the screen shows an empty string.
      You can do the following three actions any number of times in any order:

      - Spend X milliseconds to press only the 'a' key.  If the light on the Caps Lock key is off, a is appended to the string on the screen; if it is on, A is.
      - Spend Y milliseconds to press the 'a' key and Shift key simultaneously.  If the light on the Caps Lock key is off, A is appended to the string on the screen; if it is on, a is.
      - Spend Z milliseconds to press the Caps Lock key.  If the light on the Caps Lock key is off, it turns on; if it is on, it turns off.

      Given a string S consisting of A and a, determine at least how many milliseconds you need to spend to make the string shown on the screen equal to S.

      Input

      The input is given from Standard Input in the following format:
      X Y Z
      S

      Output

      Print the answer.

      Constraints


      - 1 \leq X,Y,Z \leq 10^9
      - X, Y, and Z are integers.
      - 1 \leq |S| \leq 3 \times 10^5
      - S is a string consisting of A and a.

      Sample Input 1

      1 3 3
      AAaA

      Sample Output 1

      9

      The following sequence of actions makes the string on the screen equal to AAaA in 9 milliseconds, which is the shortest possible.

      - Spend Z(=3) milliseconds to press the CapsLock key.  The light on the Caps Lock key turns on.
      - Spend X(=1) milliseconds to press the 'a' key.  A is appended to the string on the screen.
      - Spend X(=1) milliseconds to press the 'a' key.  A is appended to the string on the screen.
      - Spend Y(=3) milliseconds to press the Shift key and 'a' key simultaneously.  a is appended to the string on the screen.
      - Spend X(=1) milliseconds to press the 'a' key.  A is appended to the string on the screen.

      Sample Input 2

      1 1 100
      aAaAaA

      Sample Output 2

      6

      Sample Input 3

      1 2 4
      aaAaAaaAAAAaAaaAaAAaaaAAAAA

      Sample Output 3

      40

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "1 3 3\nAAaA\n",
              "9\n"
          ],
          [
              "1 1 100\naAaAaA\n",
              "6\n"
          ],
          [
              "1 2 4\naaAaAaaAAAAaAaaAaAAaaaAAAAA\n",
              "40\n"
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
