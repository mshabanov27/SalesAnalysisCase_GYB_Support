str_not_null.sql
{% test str_not_null(model, column_name) %}
    SELECT {{ column_name }}
    FROM {{ model }}
    WHERE {{ column_name }} IS NULL
{% endtest %}