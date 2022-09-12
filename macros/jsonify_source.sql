{% macro jsonify_source(source) %}

{% 
set jsonified_source=tojson({
    'unique_id': source.unique_id,
    'resource_type': source.resource_type,
    'identifier': source.identifier,
    'loader': source.loader,
    'config': source.config or {},
    'database': source.database or None,
    'schema': source.schema,
    'fqn': source.fqn,
    'package_name': source.package_name,
    'name': source.source_name
})
%}

{% do return(jsonified_source) %}
{% endmacro %}