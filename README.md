# debby

_Observability for dbt projects built on Snowflake_

## Install

Add this package to your `packages.yml` file.

```yml
packages:
  - git: "https://github.com/debby-sql/debby.git"
    revision: 1.0.0
```

Add the following configuration to your `dbt_project.yml` file.

```yml
query-comment:
  comment: "{{ debby.query_comment(node) }}"
  append: true

tests:
  store_failures: true
  limit: 10  
```
