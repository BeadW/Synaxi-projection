Feature: MBPP/440 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def find_adverb_position():
          pass

      === test_solution.py ===
      from solution import find_adverb_position


      def test_mbpp():
          assert find_adverb_position("clearly!! we can see the sky")==(0, 7, 'clearly')
          assert find_adverb_position("seriously!! there are many roses")==(0, 9, 'seriously')
          assert find_adverb_position("unfortunately!! sita is going to home")==(0, 13, 'unfortunately')

      """

  Scenario: Agent implements find_adverb_position so all pytest tests pass
    Given an agent is tasked with implementing the find_adverb_position function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
