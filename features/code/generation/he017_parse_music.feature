Feature: HumanEval/17 — implement parse_music
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      from typing import List


      def parse_music(music_string: str) -> List[int]:
          ''' Input to this function is a string representing musical notes in a special ASCII format.
          Your task is to parse this string and return list of integers corresponding to how many beats does each
          not last.

          Here is a legend:
          'o' - whole note, lasts four beats
          'o|' - half note, lasts two beats
          '.|' - quater note, lasts one beat

          >>> parse_music('o o| .| o| o| .| .| .| .| o o')
          [4, 2, 1, 2, 2, 1, 1, 1, 1, 4, 4]
          '''
          pass

      === test_solution.py ===
      from solution import parse_music


      def test_humaneval():
          assert parse_music('') == []
          assert parse_music('o o o o') == [4, 4, 4, 4]
          assert parse_music('.| .| .| .|') == [1, 1, 1, 1]
          assert parse_music('o| o| .| .| o o o o') == [2, 2, 1, 1, 4, 4, 4, 4]
          assert parse_music('o| .| o| .| o o| o o|') == [2, 1, 2, 1, 4, 2, 4, 2]

      """

  Scenario: Agent implements parse_music so all tests pass
    Given an agent is tasked with implementing the parse_music function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
