Feature: APPS/competition/3005 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      Spotting patterns in seemingly random strings is a problem with many applications. E.g., in our efforts to understand the genome we investigate the structure of DNA strings. In data compression we are interested in finding repetitions, so the data can be represented more efficiently with pointers. Another plausible example arises from the area of artificial intelligence, as how to interpret information given to you in a language you do not know. The natural thing to do in order to decode the information message would be to look for repetitions in it. So if the SETI project (the Search for Extra Terrestrial Intelligence) ever get a signal in the H21-spectra, we need to know how to decompose it.

      One way of capturing the redundancy of a string is to find its factoring. If two or more identical substrings $A$ follow each other in a string $S$, we can represent this aprt of $S$ as the substring $A$, enclosed by parentheses, raised to the power of the number of repetitions. E.g., the string $DOODOO$ can be factored as $(DOO)^2$, but also as $(D(O)^2)^2$. Naturally, the latter factoring is considered better since it cannot be factored any further. We say that a factoring is irreducible if it does not contain any consecutive repetition of a substring. A string may have several irreducible factorings, as seen by the example string $POPPOP$. It can be factored as $(POP)^2$, as well as $PO(P)^2OP$. The first factoring has a shorter representation and motivates the following definition. The weigh of a factoring equals the number of characters in it, excluding the parentheses and the exponents. Thus the weight of $(POP)^2$ is $3$, whereas $PO(P)^2OP$ has weight $5$. A maximal facotring is a factoring with the smallest possible weight. It should be clear that a maximal factoring is always an irreducible one, but there may still be several maximal factorings. E.g., the string $ABABA$ has two maximal factorings $(AB)^2A$ and $A(BA)^2$.

      -----Input-----
      The input consists of a sing
      ...(truncated)

      === solution.py ===
      import sys

      # Read from stdin, write answer to stdout

      === test_solution.py ===
      import subprocess
      import sys
      import pytest

      TEST_CASES = [
          [
              "PRATTATTATTIC\n",
              "6\n"
          ],
          [
              "GGGGGGGGG\n",
              "1\n"
          ],
          [
              "PRIME\n",
              "5\n"
          ],
          [
              "BABBABABBABBA\n",
              "6\n"
          ],
          [
              "ARPARPARPARPAR\n",
              "5\n"
          ]
      ]


      def test_apps():
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

  Scenario: Agent solves the APPS problem so all tests pass
    Given an agent is tasked with reading problem.txt and implementing solution.py to read from stdin and write the correct answer to stdout so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
