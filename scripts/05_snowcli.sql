use role accountadmin;
use warehouse simple_wh;
use schema git_demo_db.example_schema;


--- Run first SQL statement from SnowCLI

-- Configure ~/.snowflake/config.toml
-- Set password in the SNOWFLAKE_CONNECTS_DEMO_PASSWORD environment variable
    -- export SNOWFLAKE_CONNECTIONS_DEMO_PASSWORD=""

-- Run a simple Hello World example
    -- snow sql -q "SELECT 'Hello World!'"

--- Run our DCM process from SnowCLI

-- Review deploy_objects.sql

describe table my_inventory;

-- snow sql -q "ALTER GIT REPOSITORY GIT_SNOW_DEMO_REPOSITORY FETCH"
-- snow sql -q "EXECUTE IMMEDIATE FROM @GIT_SNOW_DEMO_REPOSITORY/branches/master/snowflake_objects/deploy_objects.sql"

describe table my_inventory;
