Feature: MBPP/459 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def remove_uppercase():
          pass

      === test_solution.py ===
      from solution import remove_uppercase


      def test_mbpp():
          assert remove_uppercase('cAstyoUrFavoRitETVshoWs') == 'cstyoravoitshos'
          assert remove_uppercase('wAtchTheinTernEtrAdIo') == 'wtchheinerntrdo'
          assert remove_uppercase('VoicESeaRchAndreComMendaTionS') == 'oiceachndreomendaion'

      """

  Scenario: Agent implements remove_uppercase so all pytest tests pass
    Given an agent is tasked with implementing the remove_uppercase function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
