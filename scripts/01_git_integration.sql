use role accountadmin;

USE DATABASE git_demo_db;
USE SCHEMA example_schema;

CREATE OR REPLACE TABLE employees(id NUMBER, name VARCHAR, role VARCHAR);
INSERT INTO employees (id, name, role) VALUES (1, 'Jane', 'op'), (2, 'Bob', 'dev'), (3, 'Cindy', 'dev');

--- Create a Secret to store the GitHub PAT
CREATE OR REPLACE SECRET git_secret
  TYPE = password
  USERNAME = 'sfc-gh-jgrip'
  PASSWORD = 'github-access-token';

show secrets;
describe secret git_secret;

--- Create a Git API integration

CREATE OR REPLACE API INTEGRATION git_api_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/sfc-gh-jgrip')
  ALLOWED_AUTHENTICATION_SECRETS = (git_secret)
  ENABLED = TRUE;

CREATE OR REPLACE GIT REPOSITORY git_snow_demo_repository
  API_INTEGRATION = git_api_integration
  GIT_CREDENTIALS = git_secret
  ORIGIN = 'https://github.com/sfc-gh-jgrip/git-snow-demo.git';

show integrations;
show api integrations;

show git repositories;
describe git repository git_snow_demo_repository;

--- List git details
list @git_snow_demo_repository/branches/master;
list @git_snow_demo_repository/tags/tag_name;
list @git_snow_demo_repository/commits/commit_hash;

show git branches in git_snow_demo_repository;
show git tags in git_snow_demo_repository;

alter git repository git_snow_demo_repository fetch;

-- Example

  CREATE OR REPLACE PROCEDURE filter_by_role(tableName VARCHAR, role VARCHAR)
    RETURNS TABLE(id NUMBER, name VARCHAR, role VARCHAR)
    LANGUAGE PYTHON
    RUNTIME_VERSION = '3.8'
    PACKAGES = ('snowflake-snowpark-python')
    IMPORTS = ('@git_demo_db.example_schema.git_snow_demo_repository/branches/master/scripts/filter.py')
    HANDLER = 'filter.filter_by_role';

  CALL filter_by_role('employees', 'dev');