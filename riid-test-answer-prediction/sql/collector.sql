{% sql 'feature' %}
CREATE TABLE IF NOT EXISTS
    {{ table_output }}
    ENGINE=MergeTree
    ORDER BY ({{ table_order_by | join(',') }})
AS
    SELECT
        {% for column_name, column_new_name in table_columns.items() %}
        {{ column_name }} AS {{ column_new_name }}
        {% if loop.last is false %}, {% endif %}
        {% endfor %}
    FROM {{ table_main }} main
    {% for t in table_join %}
    {% set outer_loop = loop %}
    LEFT JOIN {{ t.table }} t{{ outer_loop.index0 }}
    ON (
        {% for join_on in t.joins %}
        {% if loop.first is false %}AND {% endif %}
        main.{{ join_on.left }}=t{{ outer_loop.index0}}.{{ join_on.right }}
        {% endfor %}
    )
    {% endfor %}
{% endsql %}