Feature: LiveCodeBench/atcoder/hard — Modulo MST
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === problem.txt ===
      You are given a weighted simple connected undirected graph with N vertices and M edges, where vertices are numbered 1 to N, and edges are numbered 1 to M. Additionally, a positive integer K is given.
      Edge i\ (1\leq i\leq M) connects vertices u_i and v_i and has a weight of w_i.
      For a spanning tree T of this graph, the cost of T is defined as the sum, modulo K, of the weights of the edges in T.
      Find the minimum cost of a spanning tree of this graph.

      Input

      The input is given from Standard Input in the following format:
      N M K
      u_1 v_1 w_1
      u_2 v_2 w_2
      \vdots
      u_M v_M w_M

      Output

      Print the answer.

      Constraints


      - 2\leq N\leq8
      - N-1\leq M\leq\dfrac{N(N-1)}2
      - 1\leq K\leq10^{15}
      - 1\leq u_i\lt v_i\leq N\ (1\leq i\leq M)
      - 0\leq w_i\lt K\ (1\leq i\leq M)
      - The given graph is simple and connected.
      - All input values are integers.

      Sample Input 1

      5 6 328
      1 2 99
      1 3 102
      2 3 86
      2 4 94
      2 5 95
      3 4 81

      Sample Output 1

      33

      The given graph is shown below:

      The cost of the spanning tree containing edges 1,3,5,6 is (99+86+81+95)\bmod{328}=361\bmod{328}=33.
      The cost of every spanning tree of this graph is at least 33, so print 33.

      Sample Input 2

      6 5 998244353
      1 2 337361568
      1 6 450343304
      2 3 61477244
      2 5 745383438
      4 5 727360840

      Sample Output 2

      325437688

      Print the cost of the only spanning tree of this graph, which is  325437688.

      Sample Input 3

      8 28 936294041850197
      1 2 473294720906780
      1 3 743030800139244
      1 4 709363019414774
      1 5 383643612490312
      1 6 557102781022861
      1 7 623179288538138
      1 8 739618599410809
      2 3 857687812294404
      2 4 893923168139714
      2 5 581822471860662
      2 6 740549363586558
      2 7 307226438833222
      2 8 447399029952998
      3 4 636318083622768
      3 5 44548707643622
      3 6 307262781240755
      3 7 12070267388230
      3 8 700247263184082
      4 5 560567890325333
      4 6 704726113717147
      4 7 588263818615687
      4 8 549007536393172
      5 6 779230871080408
      5 7 825982583786498
      5 8 713928998174272
      6 7 751331074538826
      6 8 449873635430228
      7 8 11298381761479

      Sample Output 3

      11360716373

      Note that the input and the answer 

      === solution.py ===
      import sys

      # Read from stdin, write to stdout

      === test_solution.py ===
      import subprocess
      import sys

      TEST_CASES = [
          [
              "5 6 328\n1 2 99\n1 3 102\n2 3 86\n2 4 94\n2 5 95\n3 4 81\n",
              "33\n"
          ],
          [
              "6 5 998244353\n1 2 337361568\n1 6 450343304\n2 3 61477244\n2 5 745383438\n4 5 727360840\n",
              "325437688\n"
          ],
          [
              "8 28 936294041850197\n1 2 473294720906780\n1 3 743030800139244\n1 4 709363019414774\n1 5 383643612490312\n1 6 557102781022861\n1 7 623179288538138\n1 8 739618599410809\n2 3 857687812294404\n2 4 893923168139714\n2 5 581822471860662\n2 6 740549363586558\n2 7 307226438833222\n2 8 447399029952998\n3 4 636318083622768\n3 5 44548707643622\n3 6 307262781240755\n3 7 12070267388230\n3 8 700247263184082\n4 5 560567890325333\n4 6 704726113717147\n4 7 588263818615687\n4 8 549007536393172\n5 6 779230871080408\n5 7 825982583786498\n5 8 713928998174272\n6 7 751331074538826\n6 8 449873635430228\n7 8 11298381761479\n",
              "11360716373\n"
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
