use role useradmin;

create user dbt with password='TOPSECRET';
create role transformer;
create role transformer_prod;
grant role transformer to user dbt;
grant role transformer_prod to user dbt;

use role sysadmin;

create database dbt;
grant usage on database dbt to role transformer;
grant usage on database dbt to role transformer_prod;
grant create schema on database dbt to role transformer;
grant create schema on database dbt to role transformer_prod;

create or replace warehouse dbt with 
    AUTO_SUSPEND=60
    STATEMENT_TIMEOUT_IN_SECONDS=60;

grant usage on warehouse dbt to role transformer;
grant monitor on warehouse dbt to role transformer;
grant usage on warehouse dbt to role transformer_prod;
grant monitor on warehouse dbt to role transformer_prod;

use role accountadmin;
grant imported privileges on database snowflake to role transformer;
grant imported privileges on database snowflake to role transformer_prod;
