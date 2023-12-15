use role accountadmin;
use warehouse simple_wh;
use schema git_demo_db.example_schema;

--- Review the Snowflake objects folder
-- Browse folder structure

--- Run CREATE OR ALTER with EXECUTE IMMEDIATE FROM <file>
list @git_snow_demo_repository/branches/master/snowflake_objects;

describe table my_inventory;

-- This would make no changes to the table since the definition is the same as before
EXECUTE IMMEDIATE FROM @git_snow_demo_repository/branches/master/snowflake_objects/databases/git_demo_db/schemas/example_schema/tables/my_inventory.sql;

describe table my_inventory;

--- Make a change to the MY_INVENTORY table in code
-- Then commit it to your repo

-- Fetch new changes from the repo
alter git repository git_snow_demo_repository fetch;

-- Apply the new changes declaritively
EXECUTE IMMEDIATE FROM @git_snow_demo_repository/branches/master/snowflake_objects/databses/git_demo_db/schemas/example_schema/tables/my_inventory.sql;

describe table my_inventory;
select * from my_inventory;