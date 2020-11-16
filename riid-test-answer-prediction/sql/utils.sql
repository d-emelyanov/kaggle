{% sql 'drop_table' %}
DROP TABLE IF EXISTS {{ table }}
{% endsql %}

{% sql 'drop_temp_table' %}
DROP TEMPORARY TABLE IF EXISTS {{ table }}
{% endsql %}
