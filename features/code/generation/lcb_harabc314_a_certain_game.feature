Feature: LiveCodeBench/atcoder/hard — A Certain Game
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      N players, player 1, player 2, ..., player N, participate in a game tournament. Just before the tournament starts, each player forms a one-person team, so there are N teams in total.
      The tournament has a total of N-1 matches. In each match, two different teams are chosen. One team goes first, and the other goes second. Each match will result in exactly one team winning. Specifically, for each i = 1, 2, \ldots, N-1, the i-th match proceeds as follows.

      - The team with player p_i goes first, and the team with player q_i goes second.
      - Let a and b be the numbers of players in the first and second teams, respectively. The first team wins with probability \frac{a}{a+b}, and the second team wins with probability \frac{b}{a+b}.
      - Then, the two teams are combined into a single team.

      The result of each match is independent of those of the others.
      For each of the N players, print the expected number of times the team with that player wins throughout the tournament, modulo 998244353.
       How to print an expected value modulo 998244353
      It can be proved that the sought expected value is always rational. Also, the constraints of this problem guarantee that if the sought expected value is expressed as an irreducible fraction \frac{y}{x}, then x is not divisible by 998244353. Now, there is a unique integer z between 0 and 998244352, inclusive, such that xz \equiv y \pmod{998244353}. Report this z.

      Input

      The input is given from Standard Input in the following format:
      N
      p_1 q_1
      p_2 q_2
      \vdots
      p_{N-1} q_{N-1}

      Output

      For each i = 1, 2, \ldots, N, print E_i, the expected number, modulo 998244353, of times the team with player i wins throughout the tournament, separated by spaces, in the following format:
      E_1 E_2 \ldots E_N

      Constraints


      - 2 \leq N \leq 2 \times 10^5
      - 1 \leq p_i, q_i \leq N
      - Just before the i-th match, player p_i and player q_i belong to different teams.
      - All input values are integers.

      Sample Input 1

      5
      1 2
      4 3
      5 3
      1 4

      Sample Output 1

      698771048 698771048 9649695

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5\n1 2\n4 3\n5 3\n1 4\n",
              "698771048 698771048 964969543 964969543 133099248\n"
          ],
          [
              "15\n9 2\n8 10\n13 6\n12 11\n7 10\n4 10\n14 2\n5 4\n1 15\n15 2\n6 9\n8 11\n6 3\n2 8\n",
              "43970290 310168785 806914186 501498951 950708909 272140427 335124893 168750835 310168785 168750835 280459129 280459129 272140427 476542843 43970290\n"
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
