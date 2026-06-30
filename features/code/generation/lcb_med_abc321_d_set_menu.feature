Feature: LiveCodeBench/atcoder/medium — Set Menu
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      AtCoder cafeteria offers N main dishes and M side dishes. The price of the i-th main dish is A_i, and that of the j-th side dish is B_j.
      The cafeteria is considering introducing a new set meal menu.
      A set meal consists of one main dish and one side dish. Let s be the sum of the prices of the main dish and the side dish, then the price of the set meal is \min(s,P).
      Here, P is a constant given in the input.
      There are NM ways to choose a main dish and a side dish for a set meal. Find the total price of all these set meals.

      Input

      The input is given from Standard Input in the following format:
      N M P
      A_1 A_2 \dots A_N
      B_1 B_2 \dots B_M

      Output

      Print the answer as an integer.
      Under the constraints of this problem, it can be proved that the answer fits into a 64-bit signed integer.

      Constraints


      - 1\leq N,M \leq 2\times 10^5
      - 1\leq A_i,B_j \leq 10^8
      - 1\leq P \leq 2\times 10^8
      - All input values are integers.

      Sample Input 1

      2 2 7
      3 5
      6 1

      Sample Output 1

      24


      - If you choose the first main dish and the first side dish, the price of the set meal is \min(3+6,7)=7.
      - If you choose the first main dish and the second side dish, the price of the set meal is \min(3+1,7)=4.
      - If you choose the second main dish and the first side dish, the price of the set meal is \min(5+6,7)=7.
      - If you choose the second main dish and the second side dish, the price of the set meal is \min(5+1,7)=6.

      Thus, the answer is 7+4+7+6=24.

      Sample Input 2

      1 3 2
      1
      1 1 1

      Sample Output 2

      6

      Sample Input 3

      7 12 25514963
      2436426 24979445 61648772 23690081 33933447 76190629 62703497
      11047202 71407775 28894325 31963982 22804784 50968417 30302156 82631932 61735902 80895728 23078537 7723857

      Sample Output 3

      2115597124

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "2 2 7\n3 5\n6 1\n",
              "24\n"
          ],
          [
              "1 3 2\n1\n1 1 1\n",
              "6\n"
          ],
          [
              "7 12 25514963\n2436426 24979445 61648772 23690081 33933447 76190629 62703497\n11047202 71407775 28894325 31963982 22804784 50968417 30302156 82631932 61735902 80895728 23078537 7723857\n",
              "2115597124\n"
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
