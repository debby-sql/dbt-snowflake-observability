# debby

_Better observability for dbt projects built on Snowflake_

Debby provides near real-time views into your dbt project's health. By enriching your query logs with detailed information about which model or test was running, it's able to extract that metadata into a single table with a rich summary of your whole project.

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

Build your dbt models however you normally would. You can use `run` and then `test` or you can use the single `build` command.

```sh
dbt run ...
dbt test ...
```

Finally, build the `debby` models.

```
dbt build -s package:debby
```

Your model status will typically take about 10 minutes to appear in the views created by `debby`.

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