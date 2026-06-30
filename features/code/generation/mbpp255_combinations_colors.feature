Feature: MBPP/255 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def combinations_colors():
          pass

      === test_solution.py ===
      from solution import combinations_colors


      def test_mbpp():
          assert combinations_colors( ["Red","Green","Blue"],1)==[('Red',), ('Green',), ('Blue',)]
          assert combinations_colors( ["Red","Green","Blue"],2)==[('Red', 'Red'), ('Red', 'Green'), ('Red', 'Blue'), ('Green', 'Green'), ('Green', 'Blue'), ('Blue', 'Blue')]
          assert combinations_colors( ["Red","Green","Blue"],3)==[('Red', 'Red', 'Red'), ('Red', 'Red', 'Green'), ('Red', 'Red', 'Blue'), ('Red', 'Green', 'Green'), ('Red', 'Green', 'Blue'), ('Red', 'Blue', 'Blue'), ('Green', 'Green', 'Green'), ('Green', 'Green', 'Blue'), ('Green', 'Blue', 'Blue'), ('Blue', 'Blue', 'Blue')]

      """

  Scenario: Agent implements combinations_colors so all pytest tests pass
    Given an agent is tasked with implementing the combinations_colors function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
