Feature: Extract duplicated logic into a shared function
  Complexity: T2
  Category: code/refactor

  Background:
    Given the following Python code:
      """
      def process_user(user):
          name = user.get("name", "").strip().lower()
          email = user.get("email", "").strip().lower()
          if not name or not email:
              return None
          return {"name": name, "email": email}

      def process_admin(admin):
          name = admin.get("name", "").strip().lower()
          email = admin.get("email", "").strip().lower()
          if not name or not email:
              return None
          return {"name": name, "email": email, "role": "admin"}
      """

  Scenario: Agent extracts the shared normalisation logic
    Given an agent is tasked with refactoring to eliminate the duplication between process_user and process_admin
    When the agent completes the task
    Then the code execution script passes:
      """
      result = process_user({"name": "  Alice ", "email": "  ALICE@EXAMPLE.COM  "})
      assert result == {"name": "alice", "email": "alice@example.com"}

      result = process_admin({"name": "Bob", "email": "bob@example.com"})
      assert result == {"name": "bob", "email": "bob@example.com", "role": "admin"}

      assert process_user({"name": "", "email": "x@x.com"}) is None
      """
    And the output contains a function that is called by both process_user and process_admin
