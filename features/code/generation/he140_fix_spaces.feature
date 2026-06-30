Feature: HumanEval/140 — implement fix_spaces
  Complexity: T1
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def fix_spaces(text):
          '''
          Given a string text, replace all spaces in it with underscores, 
          and if a string has more than 2 consecutive spaces, 
          then replace all consecutive spaces with - 
    
          fix_spaces("Example") == "Example"
          fix_spaces("Example 1") == "Example_1"
          fix_spaces(" Example 2") == "_Example_2"
          fix_spaces(" Example   3") == "_Example-3"
          '''
          pass

      === test_solution.py ===
      from solution import fix_spaces


      def test_humaneval():

          # Check some simple cases
          assert fix_spaces("Example") == "Example", "This prints if this assert fails 1 (good for debugging!)"
          assert fix_spaces("Mudasir Hanif ") == "Mudasir_Hanif_", "This prints if this assert fails 2 (good for debugging!)"
          assert fix_spaces("Yellow Yellow  Dirty  Fellow") == "Yellow_Yellow__Dirty__Fellow", "This prints if this assert fails 3 (good for debugging!)"

          # Check some edge cases that are easy to work out by hand.
          assert fix_spaces("Exa   mple") == "Exa-mple", "This prints if this assert fails 4 (good for debugging!)"
          assert fix_spaces("   Exa 1 2 2 mple") == "-Exa_1_2_2_mple", "This prints if this assert fails 4 (good for debugging!)"


      """

  Scenario: Agent implements fix_spaces so all tests pass
    Given an agent is tasked with implementing the fix_spaces function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
