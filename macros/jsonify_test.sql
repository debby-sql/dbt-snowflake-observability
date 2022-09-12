{% macro jsonify_test(test) %}

{% 
set jsonified_test=tojson({
    'unique_id': test.unique_id,
    'resource_type': test.resource_type,
    'depends_on': test.depends_on,
    'config': test.config,
    'database': test.database,
    'schema': test.schema,
    'fqn': test.fqn,
    'package_name': test.package_name,
    'root_path': test.root_path,
    'path': test.path,
    'name': test.name
})
%}

{% do return(jsonified_test) %}
{% endmacro %}