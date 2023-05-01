{{ config(
    materialized='table',
    
)}}

{%- set table_names = ['raw_table1', 'raw_table2'] -%}
with audit as (
    {% for table_name in table_names -%}
    select
    '{{ table_name }}' as table_name,
    (select count(*) from dbt_demo_two.{{ table_name }} ) as rec_count,
    CURRENT_DATE as created_at
    {%- if not loop.last %}
    union all
    {% endif -%}
{%- endfor %}
)

select * from audit
