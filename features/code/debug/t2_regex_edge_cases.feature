Feature: Fix a regex that fails on edge cases
  Complexity: T2
  Category: code/debug

  Background:
    Given the following broken Python code:
      """
      import re

      def extract_emails(text):
          pattern = r'[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+'
          return re.findall(pattern, text)
      """

  Scenario: Agent fixes the regex to handle all valid email formats
    Given an agent is tasked with fixing the bug
    When the agent completes the task
    Then the code execution script passes:
      """
      results = extract_emails("Contact us at hello@example.com or support@my-company.org")
      assert "hello@example.com" in results
      assert "support@my-company.org" in results

      results = extract_emails("user.name+tag@sub.domain.co.uk")
      assert "user.name+tag@sub.domain.co.uk" in results

      results = extract_emails("no emails here")
      assert results == []

      results = extract_emails("a@b.c")
      assert "a@b.c" in results
      """
