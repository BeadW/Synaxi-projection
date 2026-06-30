Feature: Convert callback-based code to async/await
  Complexity: T2
  Category: code/refactor
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === fetcher.py ===
      import time

      def fetch_user(user_id, on_success, on_error):
          try:
              time.sleep(0)  # simulated I/O
              if user_id <= 0:
                  on_error(ValueError("invalid user_id"))
              else:
                  on_success({"id": user_id, "name": f"User{user_id}"})
          except Exception as e:
              on_error(e)

      def fetch_posts(user_id, on_success, on_error):
          try:
              time.sleep(0)
              on_success([{"title": f"Post{i}", "user_id": user_id} for i in range(3)])
          except Exception as e:
              on_error(e)

      def load_user_feed(user_id, on_done, on_error):
          def got_user(user):
              def got_posts(posts):
                  on_done({"user": user, "posts": posts})
              fetch_posts(user_id, got_posts, on_error)
          fetch_user(user_id, got_user, on_error)
      === test_fetcher.py ===
      import asyncio
      import pytest
      from fetcher import fetch_user, fetch_posts, load_user_feed

      @pytest.mark.asyncio
      async def test_fetch_user():
          user = await fetch_user(1)
          assert user["id"] == 1
          assert user["name"] == "User1"

      @pytest.mark.asyncio
      async def test_fetch_user_invalid():
          with pytest.raises(ValueError):
              await fetch_user(-1)

      @pytest.mark.asyncio
      async def test_fetch_posts():
          posts = await fetch_posts(1)
          assert len(posts) == 3
          assert all(p["user_id"] == 1 for p in posts)

      @pytest.mark.asyncio
      async def test_load_user_feed():
          feed = await load_user_feed(2)
          assert feed["user"]["id"] == 2
          assert len(feed["posts"]) == 3
      """

  Scenario: Agent converts callbacks to async/await so all tests pass
    Given an agent is tasked with refactoring fetcher.py to use async/await instead of callbacks so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
