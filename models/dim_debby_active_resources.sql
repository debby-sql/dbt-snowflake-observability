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
    parse_json('[{% for node in nodes %} "{{ node.unique_id }}" {% if not loop.last %},{% endif %} {% endfor %}]') as nodes,
    parse_json('[{% for node in nodes | selectattr("resource_type", "equalto", "model") %} "{{ node.unique_id }}" {% if not loop.last %},{% endif %} {% endfor %}]') as models,
    parse_json('[{% for node in nodes | selectattr("resource_type", "equalto", "test") %} "{{ node.unique_id }}" {% if not loop.last %},{% endif %} {% endfor %}]') as tests,
    parse_json('[{% for node in nodes | selectattr("resource_type", "equalto", "seed") %} "{{ node.unique_id }}" {% if not loop.last %},{% endif %} {% endfor %}]') as seeds,
    parse_json('[{% for node in nodes | selectattr("resource_type", "equalto", "snapshot") %} "{{ node.unique_id }}" {% if not loop.last %},{% endif %} {% endfor %}]') as snapshots,
    parse_json('[{% for source in sources %} "{{ source.unique_id }}" {% if not loop.last %},{% endif %} {% endfor %}]') as sources

