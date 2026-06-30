from pytest_bdd import scenarios

scenarios(
    "code/generation/t1_reverse_string.feature",
    "code/generation/t1_is_palindrome.feature",
    "code/generation/t2_binary_search.feature",
    "code/generation/t2_lru_cache.feature",
    "code/generation/t3_async_rate_limiter.feature",
)
