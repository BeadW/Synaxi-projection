Feature: Implement a trie with autocomplete and prefix deletion
  Complexity: T3
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === test_trie.py ===
      import pytest
      from trie import Trie

      def test_insert_and_search():
          t = Trie()
          t.insert("apple")
          assert t.search("apple") is True
          assert t.search("app") is False
          assert t.search("ap") is False

      def test_starts_with():
          t = Trie()
          t.insert("apple")
          assert t.starts_with("app") is True
          assert t.starts_with("apple") is True
          assert t.starts_with("appl") is True
          assert t.starts_with("b") is False

      def test_autocomplete():
          t = Trie()
          for word in ["apple", "app", "application", "apply", "apt", "banana"]:
              t.insert(word)
          results = sorted(t.autocomplete("app"))
          assert results == ["app", "apple", "application", "apply"]
          assert sorted(t.autocomplete("apt")) == ["apt"]
          assert t.autocomplete("xyz") == []
          assert sorted(t.autocomplete("")) == ["app", "apple", "application", "apply", "apt", "banana"]

      def test_delete():
          t = Trie()
          for w in ["apple", "app", "apply"]:
              t.insert(w)
          t.delete("app")
          assert t.search("app") is False
          assert t.search("apple") is True
          assert t.starts_with("app") is True

      def test_delete_nonexistent_raises():
          t = Trie()
          t.insert("hello")
          with pytest.raises(KeyError):
              t.delete("world")

      def test_delete_cleans_unused_nodes():
          t = Trie()
          t.insert("hello")
          t.delete("hello")
          assert t.search("hello") is False
          assert t.starts_with("h") is False

      def test_duplicate_insert():
          t = Trie()
          t.insert("test")
          t.insert("test")
          assert t.search("test") is True
          # deleting once should remove it
          t.delete("test")
          assert t.search("test") is False

      def test_word_count():
          t = Trie()
          assert t.count() == 0
          t.insert("a")
          t.insert("ab")
          t.insert("abc")
          assert t.count() == 3
          t.delete("ab")
          assert t.count() == 2
      """

  Scenario: Agent implements Trie so all tests pass
    Given an agent is tasked with implementing trie.py with a Trie class supporting insert, search, starts_with, autocomplete, delete, and count so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
