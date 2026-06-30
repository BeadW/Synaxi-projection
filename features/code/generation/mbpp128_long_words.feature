Feature: MBPP/128 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def long_words(n, str):
          pass

      === test_solution.py ===
      from solution import long_words


      def test_mbpp():
          assert long_words(3,"python is a programming language")==['python','programming','language']
          assert long_words(2,"writing a program")==['writing','program']
          assert long_words(5,"sorting list")==['sorting']

      """

  Scenario: Agent implements long_words so all pytest tests pass
    Given an agent is tasked with implementing the long_words function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
