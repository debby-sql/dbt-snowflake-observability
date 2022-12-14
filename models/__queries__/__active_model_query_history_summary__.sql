{{
    config(
        materialized='view'
    )
}}

select
    target_name,
    node_id,
    invocation_id,
    count(1) as statements,
    min(start_time) as start_time,
    max(end_time) as end_time,
    sum(total_elapsed_time) as total_elapsed_time_ms,
    sum(execution_time) as execution_time_ms,
    sum(queued_provisioning_time + queued_repair_time + queued_overload_time) as queued_time_ms,    
    sum(bytes_written) as bytes_written,
    sum(bytes_scanned) as bytes_scanned,
    sum(partitions_scanned) as partitions_scanned,
    sum(compilation_time) as compilation_time_ms,
    sum(bytes_spilled_to_local_storage) as bytes_spilled_to_local_storage,
    sum(bytes_spilled_to_remote_storage) as bytes_spilled_to_remote_storage,
    max(full_refresh) as full_refresh,
    max(has_build_error) as has_build_error,
    max(build_error_code) as build_error_code,
    max(build_error_message) as build_error_message
from {{ ref('__active_model_query_history__') }} history
group by target_name, node_id, invocation_id
