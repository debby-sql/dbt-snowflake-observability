def test_comment_schema(query_comments):
    for comment in query_comments:
        assert 'node' in comment
        assert 'dbt' in comment
        assert 'full_refresh' in comment['dbt']
