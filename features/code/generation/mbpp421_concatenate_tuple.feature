Feature: MBPP/421 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def concatenate_tuple(test_tup):
          pass

      === test_solution.py ===
      from solution import concatenate_tuple


      def test_mbpp():
          assert concatenate_tuple(("ID", "is", 4, "UTS") ) == 'ID-is-4-UTS'
          assert concatenate_tuple(("QWE", "is", 4, "RTY") ) == 'QWE-is-4-RTY'
          assert concatenate_tuple(("ZEN", "is", 4, "OP") ) == 'ZEN-is-4-OP'

      """

  Scenario: Agent implements concatenate_tuple so all pytest tests pass
    Given an agent is tasked with implementing the concatenate_tuple function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
