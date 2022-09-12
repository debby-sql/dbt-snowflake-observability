{{
    config(
        materialized='table'
    )
}}

{% if execute %}
{% set nodes = graph.nodes.values() | list %}
{% set sources = graph.sources.values() | list %}
{% else %}
{% set nodes = [] %}
{% set sources = [] %}
{% endif %}

select
    current_timestamp() as loaded_at,
    '{{ target.name }}' as target,
    '{{ invocation_id }}' as invocation_id,
    parse_json('[{% for node in nodes | selectattr("resource_type", "equalto", "model") %} {{ jsonify_model(node) }} {% if not loop.last %},{% endif %} {% endfor %}]') as models,
    parse_json('[{% for node in nodes | selectattr("resource_type", "equalto", "test") %} {{ jsonify_test(node) }} {% if not loop.last %},{% endif %} {% endfor %}]') as tests,
    parse_json('[{% for node in nodes | selectattr("resource_type", "equalto", "seed") %} {{ jsonify_seed(node) }} {% if not loop.last %},{% endif %} {% endfor %}]') as seeds,
    parse_json('[{% for node in nodes | selectattr("resource_type", "equalto", "snapshot") %} {{ jsonify_snapshot(node) }} {% if not loop.last %},{% endif %} {% endfor %}]') as snapshots,
    parse_json('[{% for source in sources %} {{ jsonify_source(source) }} {% if not loop.last %},{% endif %} {% endfor %}]') as sources

