execute immediate from './databases/git_demo_db/schemas/example_schema/tables/my_inventory.sql';

execute immediate from @git_snow_demo_repository/branches/master/snowflake_objects/databases/git_demo_db/schemas/example_schema/tables/order_template.sql
  using (DEPLOYMENT_TYPE => 'dev');