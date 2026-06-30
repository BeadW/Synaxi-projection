from pytest_bdd import scenarios

scenarios(
    "code/refactor/t1_extract_constant.feature",
    "code/refactor/t2_extract_function.feature",
    "code/refactor/t3_god_class.feature",
)
