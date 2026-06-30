Feature: LiveCodeBench/atcoder/hard — Bus Stops
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Takahashi is initially at his house and is about to visit Aoki's house.
      There are N bus stops numbered 1 to N between the two houses, and Takahashi can move between them in the following ways:

      - He can walk from his house to bus stop 1 in X units of time.
      - For each i = 1, 2, \ldots, N-1, a bus departs from bus stop i at each time that is a multiple of P_i, and by taking this bus, he can get to bus stop (i+1) in T_i units of time. Here, the constraints guarantee that 1 \leq P_i \leq 8.
      - Takahashi can walk from bus stop N to Aoki's house in Y units of time.

      For each i = 1, 2, \ldots, Q, process the following query.

      Find the earliest time that Takahashi can arrive at Aoki's house when he leaves his house at time q_i.

      Note that if he arrives at a bus stop exactly at the departure time of a bus, he can take that bus.

      Input

      The input is given from Standard Input in the following format:
      N X Y
      P_1 T_1
      P_2 T_2
      \vdots
      P_{N-1} T_{N-1}
      Q
      q_1
      q_2
      \vdots
      q_Q

      Output

      Print Q lines.
      For each i = 1, 2, \ldots, Q, the i-th line should contain the answer to the i-th query.

      Constraints


      - 2 \leq N \leq 10^5
      - 1 \leq X, Y \leq 10^9
      - 1 \leq P_i \leq 8
      - 1 \leq T_i \leq 10^9
      - 1 \leq Q \leq 2 \times 10^5
      - 0 \leq q_i \leq 10^9
      - All input values are integers.

      Sample Input 1

      4 2 3
      5 4
      6 6
      3 1
      7
      13
      0
      710511029
      136397527
      763027379
      644706927
      447672230

      Sample Output 1

      34
      22
      710511052
      136397548
      763027402
      644706946
      447672250

      For the first query, Takahashi can move as follows to arrive at Aoki's house at time 34.

      - Leave his house at time 13.
      - Walk from his house and arrive at bus stop 1 at time 15.
      - Take the bus departing from bus stop 1 at time 15 and arrive at bus stop 2 at time 19.
      - Take the bus departing from bus stop 2 at time 24 and arrive at bus stop 3 at time 30.
      - Take the bus departing from bus stop 3 at time 30 and arrive at bus stop 4 at time 31.
      - Walk from bus stop 4 and arrive at Aoki's house at time 34.

      For the second query, Taka

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "4 2 3\n5 4\n6 6\n3 1\n7\n13\n0\n710511029\n136397527\n763027379\n644706927\n447672230\n",
              "34\n22\n710511052\n136397548\n763027402\n644706946\n447672250\n"
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
