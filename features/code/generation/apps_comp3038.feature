Feature: APPS/competition/3038 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are the owner of IKEA, and you need to order a large number of bolts $B$. There is a single bolt manufacturer, but there are multiple companies reselling these bolts in packs (e.g. boxes, pallets). These companies form a directed chain, where each company buys packs from the previous company and combines these into new packs (with, of course, the logo of the company displayed brilliantly).

      At first glance, it might seem that these intermediate companies offer no advantage, as they just repack the packs of the previous company into larger packs. However, every company has their own target audience, so they want to sell packs with a specific amount of bolts. Because every company only uses the packs of the previous company, it might not be possible to create a pack that has the exact number of bolts specified. Instead, if a company wants to create a pack which is guaranteed to contain $X$ bolts, it bundles various packs from the previous company where the displayed amount of bolts on these packs sums to no less than $X$. If there are multiple such combinations it picks any from those whose displayed sum is minimal. For a better understanding, see the example below. Note that individual companies have no knowledge of the supply chain other than the pack sizes the previous company offers them.

      You realise you can take advantage of this: when a company specifies that a pack has a certain number of bolts, it might in practice contain more! Therefore you start a quest of figuring out which pack has the lowest advertised amount, while still containing at least the number of bolts you need. Thanks to your business relations, you can freely choose the company to buy a pack from, including the manufacturer.

      Explanation of first sample

      Suppose that we would like to buy $B=310$ bolts, and that there are three companies. The manufacturer (company one) sells packs of $40$ and $65$ bolts. Company two sells packs of $100$ and $150$ bolts. It cannot get these exact amounts fr
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
              "371\n3\n2 40 65\n2 100 150\n2 300 320\n",
              "impossible\n"
          ],
          [
              "310\n3\n2 40 65\n2 100 150\n2 300 320\n",
              "300\n"
          ],
          [
              "90\n2\n2 20 35\n2 88 200\n",
              "88\n"
          ],
          [
              "91\n2\n2 20 35\n2 88 200\n",
              "200\n"
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
