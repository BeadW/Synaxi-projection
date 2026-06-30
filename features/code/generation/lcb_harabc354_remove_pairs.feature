Feature: LiveCodeBench/atcoder/hard — Remove Pairs
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Takahashi and Aoki are playing a game using N cards. The front side of the i-th card has A_i written on it, and the back side has B_i written on it. Initially, the N cards are laid out on the table. With Takahashi going first, the two players take turns performing the following operation:

      - Choose a pair of cards from the table such that either the numbers on their front sides are the same or the numbers on their back sides are the same, and remove these two cards from the table. If no such pair of cards exists, the player cannot perform the operation.

      The player who is first to be unable to perform the operation loses, and the other player wins.
      Determine who wins if both players play optimally.

      Input

      The input is given from Standard Input in the following format:
      N
      A_1 B_1
      A_2 B_2
      \vdots
      A_N B_N

      Output

      Print Takahashi if Takahashi wins when both players play optimally, and Aoki otherwise.

      Constraints


      - 1 \leq N \leq 18
      - 1 \leq A_i, B_i \leq 10^9
      - All input values are integers.

      Sample Input 1

      5
      1 9
      2 5
      4 9
      1 4
      2 5

      Sample Output 1

      Aoki

      If Takahashi first removes

      - 
      the first and third cards: Aoki can win by removing the second and fifth cards.

      - 
      the first and fourth cards: Aoki can win by removing the second and fifth cards.

      - 
      the second and fifth cards: Aoki can win by removing the first and third cards.


      These are the only three pairs of cards Takahashi can remove in his first move, and Aoki can win in all cases. Therefore, the answer is Aoki.

      Sample Input 2

      9
      3 2
      1 7
      4 1
      1 8
      5 2
      9 8
      2 1
      6 8
      5 2

      Sample Output 2

      Takahashi

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5\n1 9\n2 5\n4 9\n1 4\n2 5\n",
              "Aoki\n"
          ],
          [
              "9\n3 2\n1 7\n4 1\n1 8\n5 2\n9 8\n2 1\n6 8\n5 2\n",
              "Takahashi\n"
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
