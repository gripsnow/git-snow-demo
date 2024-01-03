import pytest
from snowflake.snowpark.session import Session

def pytest_addoption(parser):
    parser.addoption("--snowflake-session", action="store", default="live")

@pytest.fixture(scope='module')
def session(request) -> Session:
    if request.config.getoption('--snowflake-session') == 'local':
        return Session.builder.config('local_testing', True).create()
    else:
        return Session.builder.configs({}).create()