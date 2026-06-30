Feature: Break apart a god class into focused classes
  Complexity: T3
  Category: code/refactor

  Background:
    Given the following Python code:
      """
      class App:
          def __init__(self):
              self.users = []
              self.db_path = "app.db"
              self.email_host = "smtp.example.com"

          def add_user(self, name, email):
              self.users.append({"name": name, "email": email})

          def get_user(self, email):
              return next((u for u in self.users if u["email"] == email), None)

          def save_to_db(self):
              import json
              with open(self.db_path, "w") as f:
                  json.dump(self.users, f)

          def load_from_db(self):
              import json
              try:
                  with open(self.db_path) as f:
                      self.users = json.load(f)
              except FileNotFoundError:
                  self.users = []

          def send_welcome_email(self, email):
              print(f"Sending welcome email via {self.email_host} to {email}")

          def send_reset_email(self, email):
              print(f"Sending reset email via {self.email_host} to {email}")
      """

  Scenario: Agent splits App into focused classes with correct behaviour
    Given an agent is tasked with refactoring to split the App class into three classes: UserRepository with add_user(name,email) and get_user(email) methods; UserStore initialised with a db_path constructor argument and having save(users) and load() methods; and EmailService with send_welcome_email(email) and send_reset_email(email) methods
    When the agent completes the task
    Then the code execution script passes:
      """
      import os, json, tempfile

      db_path = tempfile.mktemp(suffix=".db")
      repo = UserRepository()
      repo.add_user("Alice", "alice@example.com")
      repo.add_user("Bob", "bob@example.com")
      assert repo.get_user("alice@example.com") == {"name": "Alice", "email": "alice@example.com"}
      assert repo.get_user("nobody@example.com") is None

      store = UserStore(db_path)
      store.save(repo.users)
      store2 = UserStore(db_path)
      loaded = store2.load()
      assert len(loaded) == 2

      os.unlink(db_path)
      """
    And the output does not contain the text "class App:"
