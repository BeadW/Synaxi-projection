Feature: MBPP/390 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def add_string(list_, string):
          pass

      === test_solution.py ===
      from solution import add_string


      def test_mbpp():
          assert add_string([1,2,3,4],'temp{0}')==['temp1', 'temp2', 'temp3', 'temp4']
          assert add_string(['a','b','c','d'], 'python{0}')==[ 'pythona', 'pythonb', 'pythonc', 'pythond']
          assert add_string([5,6,7,8],'string{0}')==['string5', 'string6', 'string7', 'string8']

      """

  Scenario: Agent implements add_string so all pytest tests pass
    Given an agent is tasked with implementing the add_string function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
