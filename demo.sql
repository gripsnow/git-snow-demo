use role accountadmin;

CREATE DATABASE git_demo_db;
USE DATABASE git_demo_db;
CREATE SCHEMA example_schema;
USE SCHEMA example_schema;

CREATE OR REPLACE TABLE employees(id NUMBER, name VARCHAR, role VARCHAR);
INSERT INTO employees (id, name, role) VALUES (1, 'Alice', 'op'), (2, 'Bob', 'dev'), (3, 'Cindy', 'dev');

CREATE OR REPLACE SECRET git_secret
  TYPE = password
  USERNAME = 'gripsnow'
  PASSWORD = '--redacted--';

  CREATE OR REPLACE API INTEGRATION git_api_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/gripsnow')
  ALLOWED_AUTHENTICATION_SECRETS = (git_secret)
  ENABLED = TRUE;

  CREATE OR REPLACE GIT REPOSITORY git_snow_demo_repository
  API_INTEGRATION = git_api_integration
  GIT_CREDENTIALS = git_secret
  ORIGIN = 'https://github.com/gripsnow/git-snow-demo.git';

  -- pushed changes

  ALTER GIT REPOSITORY git_snow_demo_repository FETCH;

  --

   SHOW GIT BRANCHES IN git_snow_demo_repository;
   LS @git_snow_demo_repository/branches/master;
   DESCRIBE GIT REPOSITORY git_snow_demo_repository;

   --

  CREATE OR REPLACE PROCEDURE filter_by_role(tableName VARCHAR, role VARCHAR)
    RETURNS TABLE(id NUMBER, name VARCHAR, role VARCHAR)
    LANGUAGE PYTHON
    RUNTIME_VERSION = '3.8'
    PACKAGES = ('snowflake-snowpark-python')
    IMPORTS = ('@git_demo_db.example_schema.git_snow_demo_repository/branches/master/filter.py')
    HANDLER = 'filter.filter_by_role';

  CALL filter_by_role('employees', 'dev');


from snowflake.snowpark.functions import col

def filter_by_role(session, table_name, role):
  df = session.table(table_name)
  return df.filter(col("role") == role)
