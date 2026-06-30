Feature: LiveCodeBench/atcoder/medium — Many Replacement
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a string S of length N consisting of lowercase English letters.
      You will perform an operation Q times on the string S.
      The i-th operation (1\leq i\leq Q) is represented by a pair of characters (c _ i,d _ i), which corresponds to the following operation:

      - Replace all occurrences of the character c _ i in S with the character d _ i.

      Print the string S after all operations are completed.

      Input

      The input is given from Standard Input in the following format:
      N
      S
      Q
      c _ 1 d _ 1
      c _ 2 d _ 2
      \vdots
      c _ Q d _ Q

      Output

      Print the string S after all operations are completed.

      Constraints


      - 1\leq N\leq2\times10^5
      - S is a string of length N consisting of lowercase English letters.
      - 1\leq Q\leq2\times10^5
      - c _ i and d _ i are lowercase English letters (1\leq i\leq Q).
      - N and Q are integers.

      Sample Input 1

      7
      atcoder
      4
      r a
      t e
      d v
      a r

      Sample Output 1

      recover

      S changes as follows: atcoder → atcodea → aecodea → aecovea → recover.
      For example, in the fourth operation, all occurrences of a in S={}aecovea (the first and seventh characters) are replaced with r, resulting in S={}recover.
      After all operations are completed, S={}recover, so print recover.

      Sample Input 2

      3
      abc
      4
      a a
      s k
      n n
      z b

      Sample Output 2

      abc

      There may be operations where c _ i=d _ i or S does not contain c _ i.

      Sample Input 3

      34
      supercalifragilisticexpialidocious
      20
      g c
      l g
      g m
      c m
      r o
      s e
      a a
      o f
      f s
      e t
      t l
      d v
      p k
      v h
      x i
      h n
      n j
      i r
      s i
      u a

      Sample Output 3

      laklimamriiamrmrllrmlrkramrjimrial

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "7\natcoder\n4\nr a\nt e\nd v\na r\n",
              "recover\n"
          ],
          [
              "3\nabc\n4\na a\ns k\nn n\nz b\n",
              "abc\n"
          ],
          [
              "34\nsupercalifragilisticexpialidocious\n20\ng c\nl g\ng m\nc m\nr o\ns e\na a\no f\nf s\ne t\nt l\nd v\np k\nv h\nx i\nh n\nn j\ni r\ns i\nu a\n",
              "laklimamriiamrmrllrmlrkramrjimrial\n"
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
