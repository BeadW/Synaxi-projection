Feature: Implement a text diff engine producing unified diff output
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === test_diff.py ===
      import pytest
      from diff import compute_lcs, compute_diff, DiffLine

      def test_lcs_basic():
          assert compute_lcs([1,2,3], [1,2,3]) == [1,2,3]
          assert compute_lcs([1,2,3], [1,3]) == [1,3]
          assert compute_lcs([], [1,2]) == []
          assert compute_lcs([1,2], []) == []

      def test_lcs_strings():
          a = "ABCBDAB".split()
          b = "BDCAB".split()
          lcs = compute_lcs(a, b)
          assert len(lcs) == 4        # BCAB or BDAB

      def test_diff_identical():
          lines = ["a", "b", "c"]
          diff = compute_diff(lines, lines)
          assert all(d.kind == "equal" for d in diff)
          assert [d.content for d in diff] == lines

      def test_diff_insertion():
          old = ["a", "c"]
          new = ["a", "b", "c"]
          diff = compute_diff(old, new)
          kinds = [d.kind for d in diff]
          assert "insert" in kinds
          assert "delete" not in kinds

      def test_diff_deletion():
          old = ["a", "b", "c"]
          new = ["a", "c"]
          diff = compute_diff(old, new)
          kinds = [d.kind for d in diff]
          assert "delete" in kinds
          assert "insert" not in kinds

      def test_diff_replacement():
          old = ["a", "b", "c"]
          new = ["a", "X", "c"]
          diff = compute_diff(old, new)
          kinds = [d.kind for d in diff]
          assert "delete" in kinds
          assert "insert" in kinds

      def test_diff_line_content():
          old = ["hello", "world"]
          new = ["hello", "python"]
          diff = compute_diff(old, new)
          inserts = [d.content for d in diff if d.kind == "insert"]
          deletes = [d.content for d in diff if d.kind == "delete"]
          assert "python" in inserts
          assert "world" in deletes

      def test_diff_reconstruct_new():
          old = ["a", "b", "c", "d"]
          new = ["a", "X", "c", "Y", "d"]
          diff = compute_diff(old, new)
          reconstructed = [d.content for d in diff if d.kind in ("equal", "insert")]
          assert reconstructed == new

      def test_diff_reconstruct_old():
          old = ["a", "b", "c", "d"]
          new = ["a", "X", "c", "Y", "d"]
          diff = compute_diff(old, new)
          reconstructed = [d.content for d in diff if d.kind in ("equal", "delete")]
          assert reconstructed == old

      def test_diff_line_numbers():
          old = ["a", "b", "c"]
          new = ["a", "X", "c"]
          diff = compute_diff(old, new)
          for d in diff:
              assert hasattr(d, 'old_lineno')
              assert hasattr(d, 'new_lineno')
      """

  Scenario: Agent implements the diff engine so all tests pass
    Given an agent is tasked with implementing diff.py with compute_lcs(a, b), a DiffLine dataclass with kind/content/old_lineno/new_lineno fields, and compute_diff(old_lines, new_lines) returning a list of DiffLines so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
