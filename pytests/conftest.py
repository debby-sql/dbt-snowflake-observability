import json
import re

import pytest


@pytest.fixture(scope='session')
def logs():
    with open('logs/dbt.log', 'r') as fh:
        return fh.read()


@pytest.fixture(scope='session')
def query_comments(logs):
    result = []
    groups = re.findall('(\&\&DEBBY_COMMENT_START)(.*)(\&\&DEBBY_COMMENT_END)', logs)
    for group in groups:
        comment = group[1].strip()
        result.append(json.loads(comment))
    return result
