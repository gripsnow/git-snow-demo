use role accountadmin;
use warehouse simple_wh;
use schema git_demo_db.example_schema;

--- Execute scripts in a Git stage
list @git_snow_demo_repository/branches/master;
list @git_snow_demo_repository/branches/master/scripts/02_execute_immediate.sql;

show tables;

execute immediate from @git_snow_demo_repository/branches/master/scripts/02_execute_immediate/create-inventory.sql