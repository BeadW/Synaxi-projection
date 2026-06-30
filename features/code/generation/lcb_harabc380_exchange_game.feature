Feature: LiveCodeBench/atcoder/hard — Exchange Game
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Takahashi and Aoki will play a game using cards with numbers written on them.
      Initially, Takahashi has N cards with numbers A_1, \ldots, A_N in his hand, Aoki has M cards with numbers B_1, \ldots, B_M in his hand, and there are L cards with numbers C_1, \ldots, C_L on the table.
      Throughout the game, both Takahashi and Aoki know all the numbers on all the cards, including the opponent's hand.
      Starting with Takahashi, they take turns performing the following action:

      - Choose one card from his hand and put it on the table. Then, if there is a card on the table with a number less than the number on the card he just played, he may take one such card from the table into his hand.

      The player who cannot make a move first loses, and the other player wins. Determine who wins if both players play optimally.
      It can be proved that the game always ends in a finite number of moves.

      Input

      The input is given from Standard Input in the following format:
      N M L
      A_1 \ldots A_N
      B_1 \ldots B_M
      C_1 \ldots C_L

      Output

      Print Takahashi if Takahashi wins, and Aoki if Aoki wins.

      Constraints


      - 1 \leq N, M, L
      - N + M + L \leq 12
      - 1 \leq A_i, B_i, C_i \leq 10^9
      - All input values are integers.

      Sample Input 1

      1 1 2
      2
      4
      1 3

      Sample Output 1

      Aoki

      The game may proceed as follows (not necessarily optimal moves):

      - Takahashi plays 2 from his hand to the table, and takes 1 from the table into his hand. Now, Takahashi's hand is (1), Aoki's hand is (4), and the table cards are (2,3).
      - Aoki plays 4 from his hand to the table, and takes 2 into his hand. Now, Takahashi's hand is (1), Aoki's hand is (2), and the table cards are (3,4).
      - Takahashi plays 1 from his hand to the table. Now, Takahashi's hand is (), Aoki's hand is (2), and the table cards are (1,3,4).
      - Aoki plays 2 from his hand to the table. Now, Takahashi's hand is (), Aoki's hand is (), and the table cards are (1,2,3,4).
      - Takahashi cannot make a move and loses; Aoki wins.

      Sample Input 2

      4 4 4
      98 98765 987654 987654321

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "1 1 2\n2\n4\n1 3",
              "Aoki"
          ],
          [
              "4 4 4\n98 98765 987654 987654321\n987 9876 9876543 98765432\n123 12345 1234567 123456789",
              "Takahashi"
          ],
          [
              "1 1 8\n10\n10\n1 2 3 4 5 6 7 8",
              "Aoki"
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
