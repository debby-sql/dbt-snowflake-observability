{% macro jsonify_model(model) %}

{% 
set jsonified_model=tojson({
    'unique_id': model.unique_id,
    'resource_type': model.resource_type,
    'depends_on': model.depends_on,
    'config': model.config,
    'database': model.database,
    'schema': model.schema,
    'fqn': model.fqn,
    'package_name': model.package_name,
    'root_path': model.root_path,
    'path': model.path,
    'name': model.name
})
%}

{% do return(jsonified_model) %}
{% endmacro %}