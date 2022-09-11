# dbt Snowflake observability

_Better observability for dbt projects built on Snowflake_

This dbt package provides near real-time views into your dbt project's health, including tables for model status and test status. Currently it only supports dbt projects using Snowflake.

## Install

Add this package to your `packages.yml` file.

```yml
packages:
  - git: "https://github.com/debby-sql/debby.git"
    revision: 1.1.0
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

Build your dbt models.

```sh
dbt build
```

Your model status will typically take about 10 minutes to appear in the views created by `debby`.
