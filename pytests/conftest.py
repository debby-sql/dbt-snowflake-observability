import pytest


@pytest.fixture
def logs():
    with open('logs/dbt.log', 'r') as fh:
        return fh.readlines()

