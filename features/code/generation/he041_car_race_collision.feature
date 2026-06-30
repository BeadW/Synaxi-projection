Feature: HumanEval/41 — implement car_race_collision
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===


      def car_race_collision(n: int):
          '''
          Imagine a road that's a perfectly straight infinitely long line.
          n cars are driving left to right;  simultaneously, a different set of n cars
          are driving right to left.   The two sets of cars start out being very far from
          each other.  All cars move in the same speed.  Two cars are said to collide
          when a car that's moving left to right hits a car that's moving right to left.
          However, the cars are infinitely sturdy and strong; as a result, they continue moving
          in their trajectory as if they did not collide.

          This function outputs the number of such collisions.
          '''
          pass

      === test_solution.py ===
      from solution import car_race_collision


      def test_humaneval():
          assert car_race_collision(2) == 4
          assert car_race_collision(3) == 9
          assert car_race_collision(4) == 16
          assert car_race_collision(8) == 64
          assert car_race_collision(10) == 100


      """

  Scenario: Agent implements car_race_collision so all tests pass
    Given an agent is tasked with implementing the car_race_collision function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
