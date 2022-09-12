{% snapshot dbt_run_snapshots %}

{{
    config(
      target_schema=target.schema,
      strategy='timestamp',
      updated_at='current_timestamp()',
      unique_key='invocation_id'
    )
}}

select
    current_timestamp() as snapshotted_at,
    {{ target.name }} as target,
    {{ invocation_id }} as invocation_id

{% endsnapshot %}