Feature: LiveCodeBench/atcoder/hard — Ax + By < C
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given three length-N sequences of positive integers: A=(A_1,A_2,\ldots,A_N), B=(B_1,B_2,\ldots,B_N), and C=(C_1,C_2,\ldots,C_N).  
      Find the number of pairs of positive integers (x, y) that satisfy the following condition:  

      - A_i \times x + B_i \times y < C_i for all 1 \leq i \leq N.  

      It can be proved that the number of such pairs of positive integers satisfying the condition is finite.  
      You are given T test cases, each of which should be solved.

      Input

      The input is given from Standard Input in the following format. Here, \mathrm{case}_i refers to the i-th test case.
      T  
      \mathrm{case}_1  
      \mathrm{case}_2  
      \vdots  
      \mathrm{case}_T  

      Each test case is given in the following format:
      N  
      A_1 B_1 C_1  
      A_2 B_2 C_2  
      \vdots  
      A_N B_N C_N

      Output

      Print T lines. The i-th line (1 \leq i \leq T) should contain the answer for \mathrm{case}_i.

      Constraints


      - 1 \leq T \leq 2 \times 10^5 
      - 1 \leq N \leq 2 \times 10^5 
      - 1 \leq A_i, B_i, C_i \leq 10^9 
      - The sum of N over all test cases is at most 2 \times 10^5.  
      - All input values are integers.

      Sample Input 1

      2
      2
      1 1 4
      1 2 5
      1
      1 1 2

      Sample Output 1

      2
      0

      In the first test case, there are two valid pairs of integers: (x, y) = (1, 1), (2,1). Thus, the first line should contain 2.  
      In the second test case, there are no valid pairs of integers. Thus, the second line should contain 0.

      Sample Input 2

      3
      7
      138 16011 918976
      5478 7748 499926
      5234 17727 748589
      1157 10511 643136
      31200 3005 721285
      28839 14469 798851
      1933 5378 864127
      9
      17775 1665 386430
      37001 863 922418
      9756 4182 746671
      12379 9106 807578
      3984 4049 640539
      25333 9869 780810
      20372 7000 688738
      16107 11974 827227
      10779 10531 770510
      5
      4916 14132 460944
      11856 45422 610561
      56014 18216 825793
      10363 6220 945356
      37418 33866 851593

      Sample Output 2

      660
      995
      140

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "2\n2\n1 1 4\n1 2 5\n1\n1 1 2\n",
              "2\n0\n"
          ],
          [
              "3\n7\n138 16011 918976\n5478 7748 499926\n5234 17727 748589\n1157 10511 643136\n31200 3005 721285\n28839 14469 798851\n1933 5378 864127\n9\n17775 1665 386430\n37001 863 922418\n9756 4182 746671\n12379 9106 807578\n3984 4049 640539\n25333 9869 780810\n20372 7000 688738\n16107 11974 827227\n10779 10531 770510\n5\n4916 14132 460944\n11856 45422 610561\n56014 18216 825793\n10363 6220 945356\n37418 33866 851593\n",
              "660\n995\n140\n"
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
