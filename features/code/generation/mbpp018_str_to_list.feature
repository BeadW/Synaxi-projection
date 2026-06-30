Feature: MBPP/18 — 
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def str_to_list():
          pass

      === test_solution.py ===
      from solution import str_to_list


      def test_mbpp():
          assert remove_dirty_chars("probasscurve", "pros") == 'bacuve'
          assert remove_dirty_chars("digitalindia", "talent") == 'digiidi'
          assert remove_dirty_chars("exoticmiles", "toxic") == 'emles'

      """

  Scenario: Agent implements str_to_list so all pytest tests pass
    Given an agent is tasked with implementing the str_to_list function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
