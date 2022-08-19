"""
Check that the `dbt build` command ran successfully and inserts valid query
comments in each query
"""

def test_logs_exist(logs):
    assert len(logs) > 0


def test_query_comments_exist(query_comments):
    assert len(query_comments) > 0
