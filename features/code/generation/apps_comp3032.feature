Feature: APPS/competition/3032 — competitive programming problem
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      The term “Harvard architecture” applies to a computer that has physically separate memories for instructions and data. The term originated with the Harvard Mark I computer, delivered by IBM in 1944, which used paper tape for instructions and relays for data. 

      Some modern microcontrollers use the Harvard architecture – but not paper tape and relays! Data memory is organized in banks, each containing the same number of data items. Each data-referencing instruction has a byte offset $f$ to a bank, and a bit $a$ that is used to select the bank to be referenced. If $a$ is $0$, then bank $0$ is referenced. If $a$ is $1$, then the value in a bank select register (BSR) identifies the bank to be used. Assume each instruction takes the same time to execute, and there is an instruction that can set the BSR’s value.

      For example, suppose there are $4$ banks of $8$ bytes each. To access location $5$, either use a single instruction with $a = 0$ and $f = 5$, or set the BSR to $0$ in one instruction and then use an instruction with $a = 1$ and $f = 5$. The first approach is faster since it does not require setting the BSR.

      Now suppose (with the same memory) the location to access is $20$. Only one approach will work here: execute an instruction that sets the BSR to $2$ (unless the BSR already has the value $2$) and then use an instruction with $a = 1$ and $f = 4$.

      A program is a sequence of operations. Each operation is either
       - a variable reference, written as V$i$, where $i$ is a positive integer, or
       - a repetition, written as R$n$ <program> E, where $n$ is a positive integer and <program> is an arbitrary program. This operation is equivalent to $n$ sequential occurrences of <program>.

      Your problem is to determine the minimum running time of programs. In particular, given the number and size of the memory banks and a program to be executed, find the minimum number of instructions (which reference memory location and possibly set the BSR) that must be executed to run the pr
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
              "1 2\nV1 V2 V1 V1 V2\n",
              "5\n"
          ],
          [
              "2 1\nV1 V2 V1 V1 V2\n",
              "6\n"
          ],
          [
              "1 2\nR10 V1 V2 V1 E\n",
              "30\n"
          ],
          [
              "4 1\nV1 R2 V2 V4 R2 V1 E V3 E\n",
              "17\n"
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
