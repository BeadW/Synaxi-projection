Feature: LiveCodeBench/atcoder/hard — Snuke's Kyoto Trip
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given integers W,H,L,R,D,U.
      A town of Kyoto is on the two-dimensional plane.
      In the town, there is exactly one block at each lattice point (x,y) that satisfies all of the following conditions. There are no blocks at any other points.

      - 0\leq x\leq W
      - 0\leq y\leq H
      - x<L or R<x or y<D or U<y

      Snuke traveled through the town as follows.

      - First, he chooses one block and stands there.
      - Then, he performs the following operation any number of times (possibly zero):
      - Move one unit in the positive direction of the x-axis or the positive direction of the y-axis. However, the point after moving must also have a block.



      Print the number, modulo 998244353, of possible paths that Snuke could have taken.

      Input

      The input is given from Standard Input in the following format:
      W H L R D U

      Output

      Print the answer.

      Constraints


      - 0\leq L\leq R\leq W\leq 10^6
      - 0\leq D\leq U\leq H\leq 10^6
      - There is at least one block.
      - All input values are integers.

      Sample Input 1

      4 3 1 2 2 3

      Sample Output 1

      192

      The following are examples of possible paths. Here, a path is represented by listing the lattice points visited in order.

      - (3,0)
      - (0,0)\rightarrow (1,0)\rightarrow (2,0)\rightarrow (2,1)\rightarrow (3,1)\rightarrow (3,2)\rightarrow (4,2)\rightarrow (4,3)
      - (0,1)\rightarrow (0,2)

      There are 192 possible paths.

      Sample Input 2

      10 12 4 6 8 11

      Sample Output 2

      4519189

      Sample Input 3

      192 25 0 2 0 9

      Sample Output 3

      675935675

      Do not forget to print the number of paths modulo 998244353.

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "4 3 1 2 2 3",
              "192"
          ],
          [
              "10 12 4 6 8 11",
              "4519189"
          ],
          [
              "192 25 0 2 0 9",
              "675935675"
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
