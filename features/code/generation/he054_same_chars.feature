Feature: HumanEval/54 — implement same_chars
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def same_chars(s0: str, s1: str):
          '''
          Check if two words have the same characters.
          >>> same_chars('eabcdzzzz', 'dddzzzzzzzddeddabc')
          True
          >>> same_chars('abcd', 'dddddddabc')
          True
          >>> same_chars('dddddddabc', 'abcd')
          True
          >>> same_chars('eabcd', 'dddddddabc')
          False
          >>> same_chars('abcd', 'dddddddabce')
          False
          >>> same_chars('eabcdzzzz', 'dddzzzzzzzddddabc')
          False
          '''
          pass

      === test_solution.py ===
      from solution import same_chars


      def test_humaneval():
          assert same_chars('eabcdzzzz', 'dddzzzzzzzddeddabc') == True
          assert same_chars('abcd', 'dddddddabc') == True
          assert same_chars('dddddddabc', 'abcd') == True
          assert same_chars('eabcd', 'dddddddabc') == False
          assert same_chars('abcd', 'dddddddabcf') == False
          assert same_chars('eabcdzzzz', 'dddzzzzzzzddddabc') == False
          assert same_chars('aabb', 'aaccc') == False


      """

  Scenario: Agent implements same_chars so all tests pass
    Given an agent is tasked with implementing the same_chars function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
