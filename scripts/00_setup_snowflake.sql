use role accountadmin;
CREATE or replace database git_demo_db;
CREATE or replace schema example_schema;
use git_demo_db.example_schema;
drop table my_inventory;

-- Temporary fix for templating PrPr

create or replace procedure templating_cache_prewarm_dummy() returns object
    language python
    runtime_version = 3.8
    packages = ('jinja2==3.1.2', 'snowflake-snowpark-python')
    handler = 'x'
as $$
def x(session):
  pass
$$;