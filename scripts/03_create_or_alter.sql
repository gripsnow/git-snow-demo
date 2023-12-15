use role accountadmin;
use warehouse simple_wh;
use schema git_demo_db.example_schema;

--- Try out the CREATE OR ALTER command
show tables;

-- Create a table with one column
create or alter table foo
(
    column1 varchar
);

describe table foo;

-- Now add a second column
create or alter table foo
(
    column1 varchar,
    column2 varchar
);

describe table foo;

drop table foo;