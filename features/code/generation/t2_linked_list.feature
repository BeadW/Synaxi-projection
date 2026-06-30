Feature: Generate a doubly linked list with full test coverage
  Complexity: T2
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === test_linked_list.py ===
      import pytest
      from linked_list import DoublyLinkedList

      def test_append_and_iterate():
          ll = DoublyLinkedList()
          ll.append(1)
          ll.append(2)
          ll.append(3)
          assert list(ll) == [1, 2, 3]

      def test_prepend():
          ll = DoublyLinkedList()
          ll.prepend(3)
          ll.prepend(2)
          ll.prepend(1)
          assert list(ll) == [1, 2, 3]

      def test_delete():
          ll = DoublyLinkedList()
          for v in [1, 2, 3, 4]:
              ll.append(v)
          ll.delete(2)
          assert list(ll) == [1, 3, 4]
          ll.delete(1)
          assert list(ll) == [3, 4]
          ll.delete(4)
          assert list(ll) == [3]

      def test_delete_nonexistent():
          ll = DoublyLinkedList()
          ll.append(1)
          with pytest.raises(ValueError):
              ll.delete(99)

      def test_reverse():
          ll = DoublyLinkedList()
          for v in [1, 2, 3]:
              ll.append(v)
          ll.reverse()
          assert list(ll) == [3, 2, 1]

      def test_len():
          ll = DoublyLinkedList()
          assert len(ll) == 0
          ll.append(1)
          ll.append(2)
          assert len(ll) == 2

      def test_empty_reverse():
          ll = DoublyLinkedList()
          ll.reverse()
          assert list(ll) == []
      """

  Scenario: Agent implements DoublyLinkedList so all tests pass
    Given an agent is tasked with implementing linked_list.py so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
