Feature: HumanEval/18 — implement how_many_times
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def how_many_times(string: str, substring: str) -> int:
          ''' Find how many times a given substring can be found in the original string. Count overlaping cases.
          >>> how_many_times('', 'a')
          0
          >>> how_many_times('aaa', 'a')
          3
          >>> how_many_times('aaaa', 'aa')
          3
          '''
          pass

      === test_solution.py ===
      from solution import how_many_times


      def test_humaneval():
          assert how_many_times('', 'x') == 0
          assert how_many_times('xyxyxyx', 'x') == 4
          assert how_many_times('cacacacac', 'cac') == 4
          assert how_many_times('john doe', 'john') == 1

      """

  Scenario: Agent implements how_many_times so all tests pass
    Given an agent is tasked with implementing the how_many_times function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
