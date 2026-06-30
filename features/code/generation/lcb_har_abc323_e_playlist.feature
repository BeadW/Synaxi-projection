Feature: LiveCodeBench/atcoder/hard — Playlist
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Takahashi has a playlist with N songs.
      Song i (1 \leq i \leq N) lasts T_i seconds.
      Takahashi has started random play of the playlist at time 0.
      Random play repeats the following: choose one song from the N songs with equal probability and play that song to the end.
      Here, songs are played continuously: once a song ends, the next chosen song starts immediately.
      The same song can be chosen consecutively.
      Find the probability that song 1 is being played (X + 0.5) seconds after time 0, modulo 998244353.

      How to print a probability modulo 998244353
      It can be proved that the probability to be found in this problem is always a rational number.
      Also, the constraints of this problem guarantee that when the probability to be found is expressed as an irreducible fraction \frac{y}{x}, x is not divisible by 998244353.
      Then, there is a unique integer z between 0 and 998244352, inclusive, such that xz \equiv y \pmod{998244353}. Report this z.

      Input

      The input is given from Standard Input in the following format:
      N X
      T_1 T_2 \ldots T_N

      Output

      Print the probability, modulo 998244353, that the first song in the playlist is being played (X+0.5) seconds after time 0.

      Constraints


      - 2 \leq N\leq 10^3
      - 0 \leq X\leq 10^4
      - 1 \leq T_i\leq 10^4
      - All input values are integers.

      Sample Input 1

      3 6
      3 5 6

      Sample Output 1

      369720131

      Song 1 will be playing 6.5 seconds after time 0 if songs are played in one of the following orders.

      - Song 1 \to Song 1 \to Song 1
      - Song 2 \to Song 1 
      - Song 3 \to Song 1 

      The probability that one of these occurs is \frac{7}{27}.
      We have 369720131\times 27\equiv 7 \pmod{998244353}, so you should print 369720131.

      Sample Input 2

      5 0
      1 2 1 2 1

      Sample Output 2

      598946612

      0.5 seconds after time 0, the first song to be played is still playing, so the sought probability is \frac{1}{5}.
      Note that different songs may have the same length.

      Sample Input 3

      5 10000
      1 2 3 4 5

      Sample Output 3

      586965467

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 6\n3 5 6\n",
              "369720131\n"
          ],
          [
              "5 0\n1 2 1 2 1\n",
              "598946612\n"
          ],
          [
              "5 10000\n1 2 3 4 5\n",
              "586965467\n"
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
