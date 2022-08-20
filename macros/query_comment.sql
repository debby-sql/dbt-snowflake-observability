{% macro query_comment(node) %}
    {%- set comment_dict = {
        "dbt": {},
        "node": {}
    } -%}

    {%- do comment_dict['dbt'].update(
        version=dbt_version,
        profile_name=target.get('profile_name'),
        target_name=target.get('target_name'),
        invocation_id=invocation_id
    ) -%}

    {%- if node is not none -%}
      {%- do comment_dict['node'].update(
        file=node.original_file_path,
        node_id=node.unique_id,
        node_name=node.name,
        resource_type=node.resource_type,
        package_name=node.package_name,
        relation={
            "database": node.database,
            "schema": node.schema,
            "identifier": node.identifier,
            "name": node.name
        },
        materialized=node.config.get('materialized'),
        meta=node.config.get('meta'),
        tags=node.tags,
        depends_on_nodes=node.depends_on['nodes'],
        sources=node.sources,
        description=node.description

      ) -%}
    {% else %}
      {%- do comment_dict['node'].update(node_id=none) -%}
    {%- endif -%}

    {% do return('&&DEBBY_COMMENT_START ' + tojson(comment_dict) + ' &&DEBBY_COMMENT_END') %}
{% endmacro %}
