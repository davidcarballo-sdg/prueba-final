{% macro m_incremental_filter(date_column) %}
    {% if is_incremental() %}
        where {{ date_column }} > (select max(t.{{ date_column }}) from {{ this }} as t)
    {% endif %}
{% endmacro %}

