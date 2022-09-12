{% macro jsonify_snapshot(snapshot) %}

{% 
set jsonified_snapshot=tojson({
    'unique_id': snapshot.unique_id,
    'resource_type': snapshot.resource_type,
    'depends_on': snapshot.depends_on,
    'config': snapshot.config,
    'database': snapshot.database,
    'schema': snapshot.schema,
    'fqn': snapshot.fqn,
    'package_name': snapshot.package_name,
    'root_path': snapshot.root_path,
    'path': snapshot.path,
    'name': snapshot.name
})
%}

{% do return(jsonified_snapshot) %}
{% endmacro %}