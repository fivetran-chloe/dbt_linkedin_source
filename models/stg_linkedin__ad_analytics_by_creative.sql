with base as (

    select *
    from {{ source('linkedin','ad_analytics_by_creative') }}

), fields as (

    select
        creative_id,
        day as date_day,
        clicks, 
        impressions,
        cost_in_local_currency,
        cost_in_usd
    from base

), surrogate_key as (

    select
        *,
        {{ dbt_utils.surrogate_key(['date_day','creative_id']) }} as daily_creative_id
    from fields

)

select *
from surrogate_key
