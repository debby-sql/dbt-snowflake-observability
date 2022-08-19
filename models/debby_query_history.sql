{{
    config(
        materialized='view'
    )
}}

select 
    regexp_substr(query_text, '(\&\&DEBBY_COMMENT_START)(.*)(\&\&DEBBY_COMMENT_END)',1,1,'e',2) as debby_query_comment_raw,
    try_parse_json(debby_query_comment_raw) as debby_query_comment,
    debby_query_comment is not null as debby_is_valid,
    *
from {{ source('snowflake', 'query_history') }}
order by start_time desc
