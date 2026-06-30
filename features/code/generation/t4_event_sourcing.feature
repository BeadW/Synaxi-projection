Feature: Implement an event sourcing system with projections and snapshots
  Complexity: T4
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === eventsource.py ===
      '''
      Event sourcing system.

      EventStore:
          append(stream_id, event_type, payload: dict, expected_version=-1)
              Appends event; raises VersionConflict if stream version != expected_version
              (pass -1 to skip version check)
          load(stream_id) -> list[Event]
          stream_version(stream_id) -> int  (-1 if not found)

      Event(namedtuple): stream_id, version, event_type, payload, timestamp

      Projection: base class
          apply(event: Event) -> None   (override per event_type)
          rebuild(events: list[Event]) -> None

      BankAccount projection example (included for tests):
          handles: Deposited, Withdrawn, AccountOpened, AccountClosed
          properties: balance, is_open, owner

      Snapshot support:
          take_snapshot(stream_id) -> dict    saves current projection state
          load_snapshot(stream_id) -> dict|None
      '''

      class VersionConflict(Exception):
          pass

      class Event:
          def __init__(self, stream_id, version, event_type, payload, timestamp=None):
              pass

      class EventStore:
          def __init__(self):
              pass

          def append(self, stream_id: str, event_type: str, payload: dict,
                     expected_version: int = -1) -> 'Event':
              pass

          def load(self, stream_id: str) -> list:
              pass

          def stream_version(self, stream_id: str) -> int:
              pass

      class Projection:
          def apply(self, event: 'Event') -> None:
              raise NotImplementedError

          def rebuild(self, events: list) -> None:
              for e in events:
                  self.apply(e)

      class BankAccount(Projection):
          def __init__(self):
              self.balance = 0
              self.is_open = False
              self.owner = None

          def apply(self, event: 'Event') -> None:
              pass

      === test_eventsource.py ===
      import pytest
      import time
      from eventsource import EventStore, BankAccount, VersionConflict, Event

      @pytest.fixture
      def store():
          return EventStore()

      def test_append_and_load(store):
          store.append('acct-1', 'AccountOpened', {'owner': 'Alice'})
          store.append('acct-1', 'Deposited', {'amount': 100})
          events = store.load('acct-1')
          assert len(events) == 2
          assert events[0].event_type == 'AccountOpened'
          assert events[1].event_type == 'Deposited'

      def test_event_versions(store):
          store.append('s1', 'A', {})
          store.append('s1', 'B', {})
          events = store.load('s1')
          assert events[0].version == 0
          assert events[1].version == 1

      def test_stream_version(store):
          assert store.stream_version('new') == -1
          store.append('s', 'X', {})
          assert store.stream_version('s') == 0
          store.append('s', 'Y', {})
          assert store.stream_version('s') == 1

      def test_version_conflict(store):
          store.append('s', 'A', {}, expected_version=-1)
          store.append('s', 'B', {}, expected_version=0)
          with pytest.raises(VersionConflict):
              store.append('s', 'C', {}, expected_version=0)  # version is now 1

      def test_separate_streams(store):
          store.append('s1', 'X', {'v': 1})
          store.append('s2', 'X', {'v': 2})
          assert len(store.load('s1')) == 1
          assert len(store.load('s2')) == 1
          assert store.load('s1')[0].payload == {'v': 1}

      def test_load_empty_stream(store):
          assert store.load('nonexistent') == []

      def test_event_has_payload(store):
          store.append('s', 'Deposited', {'amount': 50, 'currency': 'USD'})
          e = store.load('s')[0]
          assert e.payload == {'amount': 50, 'currency': 'USD'}

      def test_bank_account_open(store):
          store.append('acct', 'AccountOpened', {'owner': 'Bob'})
          acc = BankAccount()
          acc.rebuild(store.load('acct'))
          assert acc.is_open is True
          assert acc.owner == 'Bob'
          assert acc.balance == 0

      def test_bank_account_deposit(store):
          store.append('a', 'AccountOpened', {'owner': 'X'})
          store.append('a', 'Deposited', {'amount': 200})
          store.append('a', 'Deposited', {'amount': 50})
          acc = BankAccount()
          acc.rebuild(store.load('a'))
          assert acc.balance == 250

      def test_bank_account_withdraw(store):
          store.append('a', 'AccountOpened', {'owner': 'X'})
          store.append('a', 'Deposited', {'amount': 100})
          store.append('a', 'Withdrawn', {'amount': 30})
          acc = BankAccount()
          acc.rebuild(store.load('a'))
          assert acc.balance == 70

      def test_bank_account_close(store):
          store.append('a', 'AccountOpened', {'owner': 'X'})
          store.append('a', 'AccountClosed', {})
          acc = BankAccount()
          acc.rebuild(store.load('a'))
          assert acc.is_open is False

      def test_rebuild_is_deterministic(store):
          store.append('a', 'AccountOpened', {'owner': 'Y'})
          store.append('a', 'Deposited', {'amount': 500})
          events = store.load('a')
          acc1 = BankAccount()
          acc1.rebuild(events)
          acc2 = BankAccount()
          acc2.rebuild(events)
          assert acc1.balance == acc2.balance == 500

      def test_event_has_timestamp(store):
          before = time.time()
          store.append('s', 'X', {})
          after = time.time()
          e = store.load('s')[0]
          assert e.timestamp is not None
          assert before <= e.timestamp <= after
      """

  Scenario: Agent implements an event sourcing system so all tests pass
    Given an agent is tasked with implementing an event sourcing system in eventsource.py with EventStore (append with optimistic concurrency, load, stream_version), an Event class, a Projection base class with rebuild, and a BankAccount projection handling AccountOpened/Deposited/Withdrawn/AccountClosed events so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
