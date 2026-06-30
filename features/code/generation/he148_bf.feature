Feature: HumanEval/148 — implement bf
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def bf(planet1, planet2):
          '''
          There are eight planets in our solar system: the closerst to the Sun 
          is Mercury, the next one is Venus, then Earth, Mars, Jupiter, Saturn, 
          Uranus, Neptune.
          Write a function that takes two planet names as strings planet1 and planet2. 
          The function should return a tuple containing all planets whose orbits are 
          located between the orbit of planet1 and the orbit of planet2, sorted by 
          the proximity to the sun. 
          The function should return an empty tuple if planet1 or planet2
          are not correct planet names. 
          Examples
          bf("Jupiter", "Neptune") ==> ("Saturn", "Uranus")
          bf("Earth", "Mercury") ==> ("Venus")
          bf("Mercury", "Uranus") ==> ("Venus", "Earth", "Mars", "Jupiter", "Saturn")
          '''
          pass

      === test_solution.py ===
      from solution import bf


      def test_humaneval():

          # Check some simple cases
          assert bf("Jupiter", "Neptune") == ("Saturn", "Uranus"), "First test error: " + str(len(bf("Jupiter", "Neptune")))      
          assert bf("Earth", "Mercury") == ("Venus",), "Second test error: " + str(bf("Earth", "Mercury"))  
          assert bf("Mercury", "Uranus") == ("Venus", "Earth", "Mars", "Jupiter", "Saturn"), "Third test error: " + str(bf("Mercury", "Uranus"))      
          assert bf("Neptune", "Venus") == ("Earth", "Mars", "Jupiter", "Saturn", "Uranus"), "Fourth test error: " + str(bf("Neptune", "Venus"))  


          # Check some edge cases that are easy to work out by hand.
          assert bf("Earth", "Earth") == ()
          assert bf("Mars", "Earth") == ()
          assert bf("Jupiter", "Makemake") == ()


      """

  Scenario: Agent implements bf so all tests pass
    Given an agent is tasked with implementing the bf function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
