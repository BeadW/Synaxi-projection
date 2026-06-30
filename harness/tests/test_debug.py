from pytest_bdd import scenarios

scenarios(
    "code/debug/t1_off_by_one.feature",
    "code/debug/t1_wrong_return.feature",
    "code/debug/t2_recursive_base_case.feature",
    "code/debug/t2_logic_error_fizzbuzz.feature",
    "code/debug/t3_concurrency_race.feature",
)
