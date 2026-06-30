Feature: MBPP/102 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def snake_to_camel(word):
          pass

      === test_solution.py ===
      from solution import snake_to_camel


      def test_mbpp():
          assert snake_to_camel('python_program')=='PythonProgram'
          assert snake_to_camel('python_language')==('PythonLanguage')
          assert snake_to_camel('programming_language')==('ProgrammingLanguage')

      """

  Scenario: Agent implements snake_to_camel so all pytest tests pass
    Given an agent is tasked with implementing the snake_to_camel function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
