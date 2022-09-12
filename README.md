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
dbt build ...
```

## Development

Clone this repo.

```
git clone git@github.com:debby-sql/dbt-snowflake-observability.git
```

Create a .env file containing your Snowflake credentials. Note that your credentials need access to the `snowflake` database share in your snowflake account.

```
# .env
SNOWSQL_ACCOUNT=...
SNOWSQL_USER=...
SNOWSQL_PWD=...
SNOWSQL_DATABASE=...
```

Run the setup script.

```
bin/setup
```

You should now be able to confirm your connection is working and build the models.

```
bin/dbt debug
```

The local python tests can be ran with the helper script.

```
bin/test
```