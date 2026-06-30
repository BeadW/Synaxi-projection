import re

import pytest
from pytest_bdd import given, parsers, then, when

from harness.agent import run_task
from harness.sandbox import extract_python_code, run_call, run_script


# --- Given ---

@given("the following broken Python code:", target_fixture="source_code")
@given("the following Python code:", target_fixture="source_code")
def source_code_fixture(docstring):
    return docstring.strip()


@given("an agent is tasked with fixing the bug", target_fixture="task_prompt")
def task_fix_prompt(source_code):
    return f"Fix the bug in this Python code. Return only the corrected code in a Python code block:\n\n```python\n{source_code}\n```"


@given(parsers.parse("an agent is tasked with writing {description}"), target_fixture="task_prompt")
def task_generate_prompt(description):
    return f"Write {description}. Return only the implementation as a Python code block with no explanation."


@given(parsers.parse("an agent is tasked with refactoring to {description}"), target_fixture="task_prompt")
def task_refactor_prompt(description, source_code):
    return f"Refactor the following Python code to {description}. Return only the complete refactored code in a Python code block:\n\n```python\n{source_code}\n```"


# --- When ---

@when("the agent completes the task", target_fixture="run_result")
def run_agent(task_prompt, run_context):
    result = run_task(task_prompt)
    run_context["result"] = result
    run_context["code"] = extract_python_code(result["response"])
    return result


# --- Then: function call assertions ---

@then(parsers.parse("running {func_call} returns {expected}"))
def assert_function_call(func_call, expected, run_context):
    code = run_context["code"]
    expected_val = eval(expected)
    actual = run_call(code, func_call)
    assert actual == expected_val, f"{func_call} returned {actual!r}, expected {expected_val!r}"
    run_context.setdefault("passed_checks", []).append(True)


# --- Then: script execution ---

@then("the code execution script passes:")
def assert_script_passes(docstring, run_context):
    run_script(run_context["code"], docstring.strip())
    run_context.setdefault("passed_checks", []).append(True)


# --- Then: text assertions ---

@then(parsers.parse('the output contains the text "{text}" exactly once'))
def assert_text_once(text, run_context):
    count = run_context["code"].count(text)
    assert count == 1, f"Expected '{text}' exactly once, found {count} times"


@then(parsers.parse('the output contains a function that is called by both {func_a} and {func_b}'))
def assert_shared_function(func_a, func_b, run_context):
    code = run_context["code"]
    # find all function definitions
    defs = re.findall(r"def (\w+)\(", code)
    # exclude the two named functions themselves
    helpers = [d for d in defs if d not in (func_a, func_b)]
    assert helpers, "No shared helper function found in refactored output"
    helper = helpers[0]
    assert code.count(helper) >= 3, f"Helper '{helper}' not called by both functions"


@then(parsers.parse('the output does not contain the text "{text}"'))
def assert_text_absent(text, run_context):
    assert text not in run_context["code"], f"Output should not contain '{text}'"
