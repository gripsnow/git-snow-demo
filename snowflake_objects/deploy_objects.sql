EXECUTE IMMEDIATE FROM './databases/git_demo_db/schemas/example_schema/tables/my_inventory.sql';
EXECUTE IMMEDIATE FROM './databases/git_demo_db/schemas/example_schema/tables/orders_template.sql';
  USING (DEPLOYMENT_TYPE => 'dev');