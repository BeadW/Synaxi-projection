Feature: LiveCodeBench/atcoder/medium — Who is Saikyo?
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      There are N competitive programmers numbered person 1, person 2, \ldots, and person N.
      There is a relation called superiority between the programmers.  For all pairs of distinct programmers (person X, person Y), exactly one of the following two relations holds: "person X is stronger than person Y" or "person Y is stronger than person X."
      The superiority is transitive.  In other words, for all triplets of distinct programmers (person X, person Y, person Z), it holds that:

      - if person X is stronger than person Y and person Y is stronger than person Z, then person X is stronger than person Z.

      A person X is said to be the strongest programmer if person X is stronger than person Y for all people Y other than person X.  (Under the constraints above, we can prove that there is always exactly one such person.)  
      You have M pieces of information on their superiority.  The i-th of them is that "person A_i is stronger than person B_i."
      Can you determine the strongest programmer among the N based on the information?
      If you can, print the person's number.  Otherwise, that is, if there are multiple possible strongest programmers, print -1.

      Input

      The input is given from Standard Input in the following format:
      N M
      A_1 B_1
      A_2 B_2
      \vdots
      A_M B_M

      Output

      If you can uniquely determine the strongest programmer, print the person's number; otherwise, print -1.

      Constraints


      - 2 \leq N \leq 50
      - 0 \leq M \leq \frac{N(N-1)}{2}
      - 1 \leq A_i, B_i \leq N
      - A_i \neq B_i
      - If i \neq j, then (A_i, B_i) \neq (A_j, B_j).
      - There is at least one way to determine superiorities for all pairs of distinct programmers, that is consistent with the given information.

      Sample Input 1

      3 2
      1 2
      2 3

      Sample Output 1

      1

      You have two pieces of information: "person 1 is stronger than person 2" and "person 2 is stronger than person 3."
      By the transitivity, you can also infer that "person 1 is stronger than person 3," so person 1 is the strongest programmer.

      Sample Input 2

      3 2
      1 3
      2 3

      Sample Output 2

      -1

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "3 2\n1 2\n2 3\n",
              "1\n"
          ],
          [
              "3 2\n1 3\n2 3\n",
              "-1\n"
          ],
          [
              "6 6\n1 6\n6 5\n6 2\n2 3\n4 3\n4 2\n",
              "-1\n"
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
