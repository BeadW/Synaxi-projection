Feature: LiveCodeBench/codeforces/medium — B. Chemistry
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a string $s$ of length $n$, consisting of lowercase Latin letters, and an integer $k$.

      You need to check if it is possible to remove exactly $k$ characters from the string $s$ in such a way that the remaining characters can be rearranged to form a palindrome. Note that you can reorder the remaining characters in any way.

      A palindrome is a string that reads the same forwards and backwards. For example, the strings "z", "aaa", "aba", "abccba" are palindromes, while the strings "codeforces", "reality", "ab" are not.

      Input

      Each test consists of multiple test cases. The first line contains a single integer $t$ ($1 \leq t \leq 10^4$) — the number of the test cases. This is followed by their description.

      The first line of each test case contains two integers $n$ and $k$ ($0 \leq k < n \leq 10^5$) — the length of the string $s$ and the number of characters to be deleted.

      The second line of each test case contains a string $s$ of length $n$, consisting of lowercase Latin letters.

      It is guaranteed that the sum of $n$ over all test cases does not exceed $2 \cdot 10^5$.

      Output

      For each test case, output "YES" if it is possible to remove exactly $k$ characters from the string $s$ in such a way that the remaining characters can be rearranged to form a palindrome, and "NO" otherwise.

      You can output the answer in any case (uppercase or lowercase). For example, the strings "yEs", "yes", "Yes", and "YES" will be recognized as positive answers.Sample Input 1:
      14

      1 0

      a

      2 0

      ab

      2 1

      ba

      3 1

      abb

      3 2

      abc

      6 2

      bacacd

      6 2

      fagbza

      6 2

      zwaafa

      7 2

      taagaak

      14 3

      ttrraakkttoorr

      5 3

      debdb

      5 4

      ecadc

      5 3

      debca

      5 3

      abaac



      Sample Output 1:

      YES
      NO
      YES
      YES
      YES
      YES
      NO
      NO
      YES
      YES
      YES
      YES
      NO
      YES


      Note

      In the first test case, nothing can be removed, and the string "a" is a palindrome.

      In the second test case, nothing can be removed, but the strings "ab" and "ba" are not palindromes.

      In the third test case, any character can be removed, and the resulting 

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "14\n1 0\na\n2 0\nab\n2 1\nba\n3 1\nabb\n3 2\nabc\n6 2\nbacacd\n6 2\nfagbza\n6 2\nzwaafa\n7 2\ntaagaak\n14 3\nttrraakkttoorr\n5 3\ndebdb\n5 4\necadc\n5 3\ndebca\n5 3\nabaac\n",
              "YES\nNO\nYES\nYES\nYES\nYES\nNO\nNO\nYES\nYES\nYES\nYES\nNO\nYES\n"
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
