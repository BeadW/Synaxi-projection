Feature: HumanEval/16 — implement count_distinct_characters
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def count_distinct_characters(string: str) -> int:
          ''' Given a string, find out how many distinct characters (regardless of case) does it consist of
          >>> count_distinct_characters('xyzXYZ')
          3
          >>> count_distinct_characters('Jerry')
          4
          '''
          pass

      === test_solution.py ===
      from solution import count_distinct_characters


      def test_humaneval():
          assert count_distinct_characters('') == 0
          assert count_distinct_characters('abcde') == 5
          assert count_distinct_characters('abcde' + 'cade' + 'CADE') == 5
          assert count_distinct_characters('aaaaAAAAaaaa') == 1
          assert count_distinct_characters('Jerry jERRY JeRRRY') == 5

      """

  Scenario: Agent implements count_distinct_characters so all tests pass
    Given an agent is tasked with implementing the count_distinct_characters function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
