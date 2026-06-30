Feature: MBPP/456 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def reverse_string_list(stringlist):
          pass

      === test_solution.py ===
      from solution import reverse_string_list


      def test_mbpp():
          assert reverse_string_list(['Red', 'Green', 'Blue', 'White', 'Black'])==['deR', 'neerG', 'eulB', 'etihW', 'kcalB']
          assert reverse_string_list(['john','amal','joel','george'])==['nhoj','lama','leoj','egroeg']
          assert reverse_string_list(['jack','john','mary'])==['kcaj','nhoj','yram']

      """

  Scenario: Agent implements reverse_string_list so all pytest tests pass
    Given an agent is tasked with implementing the reverse_string_list function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
