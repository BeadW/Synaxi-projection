Feature: HumanEval/147 — implement get_max_triples
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def get_max_triples(n):
          '''
          You are given a positive integer n. You have to create an integer array a of length n.
              For each i (1 ≤ i ≤ n), the value of a[i] = i * i - i + 1.
              Return the number of triples (a[i], a[j], a[k]) of a where i < j < k, 
          and a[i] + a[j] + a[k] is a multiple of 3.

          Example :
              Input: n = 5
              Output: 1
              Explanation: 
              a = [1, 3, 7, 13, 21]
              The only valid triple is (1, 7, 13).
          '''
          pass

      === test_solution.py ===
      from solution import get_max_triples


      def test_humaneval():

          assert get_max_triples(5) == 1
          assert get_max_triples(6) == 4
          assert get_max_triples(10) == 36
          assert get_max_triples(100) == 53361

      """

  Scenario: Agent implements get_max_triples so all tests pass
    Given an agent is tasked with implementing the get_max_triples function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
