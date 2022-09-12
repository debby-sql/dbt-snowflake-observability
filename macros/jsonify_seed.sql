{% macro jsonify_seed(seed) %}

{% 
set jsonified_seed=tojson({
    'unique_id': seed.unique_id,
    'resource_type': seed.resource_type,
    'config': seed.config,
    'database': seed.database,
    'schema': seed.schema,
    'fqn': seed.fqn,
    'package_name': seed.package_name,
    'root_path': seed.root_path,
    'path': seed.path,
    'name': seed.name
})
%}

{% do return(jsonified_seed) %}
{% endmacro %}