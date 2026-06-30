Feature: MBPP/411 — 
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===
      def snake_to_camel():
          pass

      === test_solution.py ===
      from solution import snake_to_camel


      def test_mbpp():
          assert snake_to_camel('android_tv') == 'AndroidTv'
          assert snake_to_camel('google_pixel') == 'GooglePixel'
          assert snake_to_camel('apple_watch') == 'AppleWatch'

      """

  Scenario: Agent implements snake_to_camel so all pytest tests pass
    Given an agent is tasked with implementing the snake_to_camel function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
