Feature: Implement a regex engine supporting . * + ? | and groups
  Complexity: T4
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === regex.py ===
      '''
      NFA-based regex engine (Thompson construction or backtracking).

      Supported syntax:
        .       any character
        *       zero or more (greedy)
        +       one or more (greedy)
        ?       zero or one
        |       alternation
        (...)   grouping
        [abc]   character class
        [^abc]  negated character class
        \d \w \s  escape sequences (digit, word char, whitespace)
        ^  $    anchors

      API:
        match(pattern, string) -> Match | None
            Match.group(0) -> full match string
            Match.start() -> start index
            Match.end()   -> end index

        search(pattern, string) -> Match | None   (find anywhere)
        findall(pattern, string) -> list[str]     (all non-overlapping)
        fullmatch(pattern, string) -> Match | None
      '''

      class Match:
          def __init__(self, string, start, end):
              self._string = string
              self._start = start
              self._end = end

          def group(self, n=0):
              if n == 0:
                  return self._string[self._start:self._end]
              raise IndexError(n)

          def start(self):
              return self._start

          def end(self):
              return self._end

      def match(pattern: str, string: str):
          pass

      def search(pattern: str, string: str):
          pass

      def findall(pattern: str, string: str) -> list:
          pass

      def fullmatch(pattern: str, string: str):
          pass

      === test_regex.py ===
      import pytest
      from regex import match, search, findall, fullmatch

      # ── match (anchored at start) ──────────────────────────────────────────

      def test_match_literal():
          m = match('abc', 'abcdef')
          assert m is not None
          assert m.group(0) == 'abc'
          assert m.start() == 0
          assert m.end() == 3

      def test_match_literal_fail():
          assert match('xyz', 'abcdef') is None

      def test_match_dot():
          m = match('a.c', 'abc')
          assert m is not None
          assert m.group(0) == 'abc'

      def test_match_dot_fail():
          assert match('a.c', 'ac') is None

      def test_match_star():
          assert match('a*', '') is not None
          assert match('a*', 'aaa') is not None
          m = match('a*b', 'aaab')
          assert m.group(0) == 'aaab'

      def test_match_plus():
          assert match('a+', 'a') is not None
          assert match('a+', 'aaa') is not None
          assert match('a+', '') is None

      def test_match_question():
          assert match('colou?r', 'color') is not None
          assert match('colou?r', 'colour') is not None
          assert match('colou?r', 'colouur') is None

      def test_match_alternation():
          assert match('cat|dog', 'cat') is not None
          assert match('cat|dog', 'dog') is not None
          assert match('cat|dog', 'bird') is None

      def test_match_group():
          m = match('(ab)+', 'ababab')
          assert m is not None
          assert m.group(0) == 'ababab'

      def test_match_anchor_start():
          assert match('^abc', 'abcdef') is not None
          assert match('^abc', 'xabcdef') is None

      # ── fullmatch ──────────────────────────────────────────────────────────

      def test_fullmatch_success():
          assert fullmatch('a+b+', 'aaabbb') is not None

      def test_fullmatch_fail():
          assert fullmatch('a+b+', 'aaabbbX') is None

      def test_fullmatch_anchor_end():
          assert fullmatch('abc$', 'abc') is not None
          assert fullmatch('abc$', 'abcd') is None

      # ── search ────────────────────────────────────────────────────────────

      def test_search_middle():
          m = search('b+', 'aabbbcc')
          assert m is not None
          assert m.group(0) == 'bbb'
          assert m.start() == 2

      def test_search_not_found():
          assert search('xyz', 'abcdef') is None

      def test_search_with_dot_star():
          m = search('a.*z', 'xyzaz123')
          assert m is not None

      # ── findall ───────────────────────────────────────────────────────────

      def test_findall_digits():
          assert findall(r'\d+', 'abc 123 def 456') == ['123', '456']

      def test_findall_words():
          assert findall(r'\w+', 'hello world') == ['hello', 'world']

      def test_findall_empty():
          assert findall('xyz', 'abcdef') == []

      def test_findall_nonoverlapping():
          assert findall('aa', 'aaaa') == ['aa', 'aa']

      # ── character classes ──────────────────────────────────────────────────

      def test_char_class():
          m = match('[aeiou]+', 'aeiou')
          assert m is not None and m.group(0) == 'aeiou'

      def test_negated_class():
          m = match('[^aeiou]+', 'bcd')
          assert m is not None

      def test_escape_digit():
          assert match(r'\d+', '123abc') is not None
          assert match(r'\d+', 'abc') is None

      def test_escape_word():
          assert match(r'\w+', 'hello_world') is not None

      def test_escape_whitespace():
          assert match(r'\s+', '   \t\n') is not None
      """

  Scenario: Agent implements a regex engine so all tests pass
    Given an agent is tasked with implementing a regex engine in regex.py supporting dot, star, plus, question, alternation, grouping, character classes, escape sequences, and anchors with match, search, findall, and fullmatch functions so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
