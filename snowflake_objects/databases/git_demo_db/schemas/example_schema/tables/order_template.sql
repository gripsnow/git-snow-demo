--!jinja2

{% if DEPLOYMENT_TYPE == 'prod' %}
  {% set environments = ['prod1', 'prod2'] %}
{% else %}
  {% set environments = ['dev', 'qa', 'staging'] %}
{% endif %}

use git_demo_db.example_schema;
{% for environment in environments %}
  create or alter table {{ environment }}_orders (
    id number,
    item varchar,
    quantity number);
{% endfor %}