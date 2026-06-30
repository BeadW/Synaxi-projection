Feature: LiveCodeBench/atcoder/medium — False Hope
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is a 3\times3 grid with numbers between 1 and 9, inclusive, written in each square. The square at the i-th row from the top and j-th column from the left (1\leq i\leq3,1\leq j\leq3) contains the number c _ {i,j}.
      The same number may be written in different squares, but not in three consecutive cells vertically, horizontally, or diagonally.
      More precisely, it is guaranteed that c _ {i,j} satisfies all of the following conditions.

      - c _ {i,1}=c _ {i,2}=c _ {i,3} does not hold for any 1\leq i\leq3. 
      - c _ {1,j}=c _ {2,j}=c _ {3,j} does not hold for any 1\leq j\leq3.
      - c _ {1,1}=c _ {2,2}=c _ {3,3} does not hold.
      - c _ {3,1}=c _ {2,2}=c _ {1,3} does not hold.

      Takahashi will see the numbers written in each cell in random order.
      He will get disappointed when there is a line (vertical, horizontal, or diagonal) that satisfies the following condition.

      - The first two squares he sees contain the same number, but the last square contains a different number.

      Find the probability that Takahashi sees the numbers in all the squares without getting disappointed.

      Input

      The input is given from Standard Input in the following format:
      c _ {1,1} c _ {1,2} c _ {1,3}
      c _ {2,1} c _ {2,2} c _ {2,3}
      c _ {3,1} c _ {3,2} c _ {3,3}

      Output

      Print one line containing the probability that Takahashi sees the numbers in all the squares without getting disappointed.
      Your answer will be considered correct if the absolute error from the true value is at most 10 ^ {-8}.

      Constraints


      - c _ {i,j}\in\lbrace1,2,3,4,5,6,7,8,9\rbrace\ (1\leq i\leq3,1\leq j\leq3)
      - c _ {i,1}=c _ {i,2}=c _ {i,3} does not hold for any 1\leq i\leq3. 
      - c _ {1,j}=c _ {2,j}=c _ {3,j} does not hold for any 1\leq j\leq3.
      - c _ {1,1}=c _ {2,2}=c _ {3,3} does not hold.
      - c _ {3,1}=c _ {2,2}=c _ {1,3} does not hold.

      Sample Input 1

      3 1 9
      2 5 6
      2 7 1

      Sample Output 1

      0.666666666666666666666666666667

      For example, if Takahashi sees c _ {3,1}=2,c _ {2,1}=2,c _ {1,1}=3 in this order, he will get disappointed.

      On th

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 1 9\n2 5 6\n2 7 1\n",
              "0.666666666666666666666666666667\n"
          ],
          [
              "7 7 6\n8 6 8\n7 7 6\n",
              "0.004982363315696649029982363316\n"
          ],
          [
              "3 6 7\n1 9 7\n5 7 5\n",
              "0.4\n"
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
