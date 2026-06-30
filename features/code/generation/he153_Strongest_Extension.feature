Feature: HumanEval/153 — implement Strongest_Extension
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === solution.py ===

      def Strongest_Extension(class_name, extensions):
          '''You will be given the name of a class (a string) and a list of extensions.
          The extensions are to be used to load additional classes to the class. The
          strength of the extension is as follows: Let CAP be the number of the uppercase
          letters in the extension's name, and let SM be the number of lowercase letters 
          in the extension's name, the strength is given by the fraction CAP - SM. 
          You should find the strongest extension and return a string in this 
          format: ClassName.StrongestExtensionName.
          If there are two or more extensions with the same strength, you should
          choose the one that comes first in the list.
          For example, if you are given "Slices" as the class and a list of the
          extensions: ['SErviNGSliCes', 'Cheese', 'StuFfed'] then you should
          return 'Slices.SErviNGSliCes' since 'SErviNGSliCes' is the strongest extension 
          (its strength is -1).
          Example:
          for Strongest_Extension('my_class', ['AA', 'Be', 'CC']) == 'my_class.AA'
          '''
          pass

      === test_solution.py ===
      from solution import Strongest_Extension


      def test_humaneval():

          # Check some simple cases
          assert Strongest_Extension('Watashi', ['tEN', 'niNE', 'eIGHt8OKe']) == 'Watashi.eIGHt8OKe'
          assert Strongest_Extension('Boku123', ['nani', 'NazeDa', 'YEs.WeCaNe', '32145tggg']) == 'Boku123.YEs.WeCaNe'
          assert Strongest_Extension('__YESIMHERE', ['t', 'eMptY', 'nothing', 'zeR00', 'NuLl__', '123NoooneB321']) == '__YESIMHERE.NuLl__'
          assert Strongest_Extension('K', ['Ta', 'TAR', 't234An', 'cosSo']) == 'K.TAR'
          assert Strongest_Extension('__HAHA', ['Tab', '123', '781345', '-_-']) == '__HAHA.123'
          assert Strongest_Extension('YameRore', ['HhAas', 'okIWILL123', 'WorkOut', 'Fails', '-_-']) == 'YameRore.okIWILL123'
          assert Strongest_Extension('finNNalLLly', ['Die', 'NowW', 'Wow', 'WoW']) == 'finNNalLLly.WoW'

          # Check some edge cases that are easy to work out by hand.
          assert Strongest_Extension('_', ['Bb', '91245']) == '_.Bb'
          assert Strongest_Extension('Sp', ['671235', 'Bb']) == 'Sp.671235'


      """

  Scenario: Agent implements Strongest_Extension so all tests pass
    Given an agent is tasked with implementing the Strongest_Extension function in solution.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
