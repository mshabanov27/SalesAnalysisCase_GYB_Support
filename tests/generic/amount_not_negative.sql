amount_not_negative.sql
{% test amount_not_negative(model, column_name) %}
    SELECT {{ column_name }}
    FROM {{ model }}
    WHERE {{ column_name }} < 0
{% endtest %}