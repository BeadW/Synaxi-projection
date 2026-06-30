Feature: MBPP/301 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def dict_depth(d):
          pass

      === test_solution.py ===
      from solution import dict_depth


      def test_mbpp():
          assert dict_depth({'a':1, 'b': {'c': {'d': {}}}})==4
          assert dict_depth({'a':1, 'b': {'c':'python'}})==2
          assert dict_depth({1: 'Sun', 2: {3: {4:'Mon'}}})==3

      """

  Scenario: Agent implements dict_depth so all pytest tests pass
    Given an agent is tasked with implementing the dict_depth function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
