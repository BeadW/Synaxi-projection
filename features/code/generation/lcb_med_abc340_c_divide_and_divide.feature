Feature: LiveCodeBench/atcoder/medium — Divide and Divide
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There is a single integer N written on a blackboard.
      Takahashi will repeat the following series of operations until all integers not less than 2 are removed from the blackboard:

      - Choose one integer x not less than 2 written on the blackboard.
      - Erase one occurrence of x from the blackboard. Then, write two new integers \left \lfloor \dfrac{x}{2} \right\rfloor and \left\lceil \dfrac{x}{2} \right\rceil on the blackboard.
      - Takahashi must pay x yen to perform this series of operations.

      Here, \lfloor a \rfloor denotes the largest integer not greater than a, and \lceil a \rceil denotes the smallest integer not less than a.
      What is the total amount of money Takahashi will have paid when no more operations can be performed?
      It can be proved that the total amount he will pay is constant regardless of the order in which the operations are performed.

      Input

      The input is given from Standard Input in the following format:
      N

      Output

      Print the total amount of money Takahashi will have paid, in yen.

      Constraints


      - 2 \leq N \leq 10^{17}

      Sample Input 1

      3

      Sample Output 1

      5

      Here is an example of how Takahashi performs the operations:

      - Initially, there is one 3 written on the blackboard.
      - He chooses 3. He pays 3 yen, erases one 3 from the blackboard, and writes \left \lfloor \dfrac{3}{2} \right\rfloor = 1 and \left\lceil \dfrac{3}{2} \right\rceil = 2 on the blackboard.
      - There is one 2 and one 1 written on the blackboard.
      - He chooses 2. He pays 2 yen, erases one 2 from the blackboard, and writes \left \lfloor \dfrac{2}{2} \right\rfloor = 1 and \left\lceil \dfrac{2}{2} \right\rceil = 1 on the blackboard.
      - There are three 1s written on the blackboard.
      - Since all integers not less than 2 have been removed from the blackboard, the process is finished.

      Takahashi has paid a total of 3 + 2 = 5 yen for the entire process, so print 5.

      Sample Input 2

      340

      Sample Output 2

      2888

      Sample Input 3

      100000000000000000

      Sample Output 3

      5655884811924144128

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3\n",
              "5\n"
          ],
          [
              "340\n",
              "2888\n"
          ],
          [
              "100000000000000000\n",
              "5655884811924144128\n"
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
