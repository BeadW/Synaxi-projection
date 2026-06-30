Feature: Split a monolithic data processing script into a proper module
  Complexity: T3
  Category: code/refactor
  Mode: multi-turn

  Background:
    Given the following project files:
      """
      === processor.py ===
      import csv
      import json
      import statistics
      from pathlib import Path

      def process_sales_data(csv_path):
          # Load
          rows = []
          with open(csv_path) as f:
              reader = csv.DictReader(f)
              for row in reader:
                  rows.append({
                      "region": row["region"],
                      "product": row["product"],
                      "amount": float(row["amount"]),
                      "month": int(row["month"]),
                  })

          # Validate
          for i, row in enumerate(rows):
              if row["amount"] < 0:
                  raise ValueError(f"Row {i}: negative amount {row['amount']}")
              if not 1 <= row["month"] <= 12:
                  raise ValueError(f"Row {i}: invalid month {row['month']}")

          # Aggregate by region
          by_region = {}
          for row in rows:
              r = row["region"]
              if r not in by_region:
                  by_region[r] = []
              by_region[r].append(row["amount"])

          # Stats per region
          region_stats = {}
          for region, amounts in by_region.items():
              region_stats[region] = {
                  "total": sum(amounts),
                  "mean": statistics.mean(amounts),
                  "median": statistics.median(amounts),
                  "count": len(amounts),
              }

          # Top products
          by_product = {}
          for row in rows:
              p = row["product"]
              by_product[p] = by_product.get(p, 0) + row["amount"]
          top_products = sorted(by_product.items(), key=lambda x: x[1], reverse=True)[:5]

          return {
              "total_records": len(rows),
              "region_stats": region_stats,
              "top_products": [{"product": p, "total": t} for p, t in top_products],
          }

      def save_report(report, output_path):
          Path(output_path).write_text(json.dumps(report, indent=2))
      === test_processor.py ===
      import csv
      import json
      import os
      import tempfile
      import pytest

      # After refactoring, the tests import from the new module structure.
      # The agent must create the right files so these imports work.
      from sales.loader import load_csv
      from sales.validator import validate_rows
      from sales.aggregator import aggregate_by_region, top_products
      from sales.reporter import build_report, save_report

      def _write_csv(rows, path):
          with open(path, "w", newline="") as f:
              w = csv.DictWriter(f, fieldnames=["region", "product", "amount", "month"])
              w.writeheader()
              w.writerows(rows)

      SAMPLE = [
          {"region": "North", "product": "A", "amount": "100", "month": "1"},
          {"region": "North", "product": "B", "amount": "200", "month": "2"},
          {"region": "South", "product": "A", "amount": "150", "month": "1"},
          {"region": "South", "product": "C", "amount": "50",  "month": "3"},
      ]

      def test_load_csv(tmp_path):
          p = tmp_path / "sales.csv"
          _write_csv(SAMPLE, p)
          rows = load_csv(p)
          assert len(rows) == 4
          assert rows[0]["amount"] == 100.0
          assert rows[0]["month"] == 1

      def test_validate_ok(tmp_path):
          p = tmp_path / "sales.csv"
          _write_csv(SAMPLE, p)
          rows = load_csv(p)
          validate_rows(rows)  # should not raise

      def test_validate_negative(tmp_path):
          bad = [{"region": "X", "product": "Y", "amount": "-1", "month": "1"}]
          p = tmp_path / "bad.csv"
          _write_csv(bad, p)
          rows = load_csv(p)
          with pytest.raises(ValueError):
              validate_rows(rows)

      def test_aggregate(tmp_path):
          p = tmp_path / "sales.csv"
          _write_csv(SAMPLE, p)
          rows = load_csv(p)
          stats = aggregate_by_region(rows)
          assert abs(stats["North"]["total"] - 300) < 0.01
          assert abs(stats["South"]["total"] - 200) < 0.01

      def test_top_products(tmp_path):
          p = tmp_path / "sales.csv"
          _write_csv(SAMPLE, p)
          rows = load_csv(p)
          top = top_products(rows, n=2)
          assert top[0]["product"] == "A"
          assert len(top) == 2

      def test_save_report(tmp_path):
          report = {"total_records": 4, "region_stats": {}, "top_products": []}
          out = tmp_path / "report.json"
          save_report(report, out)
          loaded = json.loads(out.read_text())
          assert loaded["total_records"] == 4
      """

  Scenario: Agent refactors into a sales package so all tests pass
    Given an agent is tasked with refactoring processor.py into a sales/ package with loader, validator, aggregator, and reporter modules so all pytest tests pass
    When the agent completes the task in the sandbox
    Then pytest exits with code 0
