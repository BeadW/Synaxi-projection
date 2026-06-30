Feature: Implement a DAG-based job scheduler with priorities and dependency resolution
  Complexity: T4
  Category: code/generation
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === scheduler.py ===
      '''
      DAG-based job scheduler.

      Job: id, fn (callable), deps (list of job ids), priority (int, higher = first)
      Scheduler:
        add_job(id, fn, deps=[], priority=0)
        run() -> dict[id, result]   executes jobs in dependency order,
                                    breaking ties by priority (desc), then id
        get_result(id) -> any
        reset()  clear results, keep job definitions

      Raises:
        CycleError   if dependency graph has a cycle
        ValueError   if a dependency id is unknown
      '''

      class CycleError(Exception):
          pass

      class Scheduler:
          def __init__(self):
              pass

          def add_job(self, job_id, fn, deps=None, priority=0):
              pass

          def run(self) -> dict:
              pass

          def get_result(self, job_id):
              pass

          def reset(self):
              pass

      === test_scheduler.py ===
      import pytest
      from scheduler import Scheduler, CycleError

      def test_single_job():
          s = Scheduler()
          s.add_job('a', lambda: 42)
          results = s.run()
          assert results['a'] == 42

      def test_sequential_deps():
          s = Scheduler()
          s.add_job('a', lambda: 1)
          s.add_job('b', lambda: s.get_result('a') + 1, deps=['a'])
          s.add_job('c', lambda: s.get_result('b') + 1, deps=['b'])
          results = s.run()
          assert results == {'a': 1, 'b': 2, 'c': 3}

      def test_diamond_deps():
          s = Scheduler()
          s.add_job('a', lambda: 10)
          s.add_job('b', lambda: s.get_result('a') * 2, deps=['a'])
          s.add_job('c', lambda: s.get_result('a') * 3, deps=['a'])
          s.add_job('d', lambda: s.get_result('b') + s.get_result('c'), deps=['b', 'c'])
          results = s.run()
          assert results['d'] == 50  # 20 + 30

      def test_priority_breaks_tie():
          order = []
          s = Scheduler()
          s.add_job('lo', lambda: order.append('lo'), priority=1)
          s.add_job('hi', lambda: order.append('hi'), priority=10)
          s.add_job('mid', lambda: order.append('mid'), priority=5)
          s.run()
          assert order == ['hi', 'mid', 'lo']

      def test_priority_after_deps():
          order = []
          s = Scheduler()
          s.add_job('root', lambda: order.append('root'), priority=0)
          s.add_job('child_hi', lambda: order.append('child_hi'), deps=['root'], priority=10)
          s.add_job('child_lo', lambda: order.append('child_lo'), deps=['root'], priority=1)
          s.run()
          assert order[0] == 'root'
          assert order[1] == 'child_hi'
          assert order[2] == 'child_lo'

      def test_cycle_raises():
          s = Scheduler()
          s.add_job('a', lambda: 1, deps=['b'])
          s.add_job('b', lambda: 1, deps=['a'])
          with pytest.raises(CycleError):
              s.run()

      def test_unknown_dep_raises():
          s = Scheduler()
          s.add_job('a', lambda: 1, deps=['nonexistent'])
          with pytest.raises(ValueError):
              s.run()

      def test_get_result_before_run_raises():
          s = Scheduler()
          s.add_job('a', lambda: 1)
          with pytest.raises((KeyError, RuntimeError, ValueError)):
              s.get_result('a')

      def test_reset_clears_results():
          s = Scheduler()
          s.add_job('a', lambda: 99)
          s.run()
          assert s.get_result('a') == 99
          s.reset()
          with pytest.raises((KeyError, RuntimeError, ValueError)):
              s.get_result('a')

      def test_reset_keeps_jobs():
          s = Scheduler()
          s.add_job('a', lambda: 7)
          s.run()
          s.reset()
          results = s.run()
          assert results['a'] == 7

      def test_multiple_roots():
          s = Scheduler()
          s.add_job('x', lambda: 10)
          s.add_job('y', lambda: 20)
          s.add_job('z', lambda: s.get_result('x') + s.get_result('y'), deps=['x', 'y'])
          results = s.run()
          assert results['z'] == 30

      def test_no_jobs():
          s = Scheduler()
          assert s.run() == {}

      def test_job_exception_propagates():
          s = Scheduler()
          s.add_job('bad', lambda: 1 / 0)
          with pytest.raises(ZeroDivisionError):
              s.run()
      """

  Scenario: Agent implements a job scheduler so all tests pass
    Given an agent is tasked with implementing a DAG-based job scheduler in scheduler.py with add_job, run, get_result, and reset methods that respect dependency ordering and priority, raising CycleError for cycles and ValueError for unknown deps so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
