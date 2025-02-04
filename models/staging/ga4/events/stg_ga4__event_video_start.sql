-- Defined as when the video starts playing. For embedded YouTube videos that have JS API support enabled. Collected by default via enhanced measurement.
-- More info: https://support.google.com/firebase/answer/9234069?hl=en
 
 with video_start_with_params as (
   select *,
      {{ ga4.unnest_key('event_params', 'video_current_time', 'int_value') }},
      {{ ga4.unnest_key('event_params', 'video_duration', 'int_value') }},
      {{ ga4.unnest_key('event_params', 'video_percent', 'int_value') }},
      {{ ga4.unnest_key('event_params', 'video_url') }},
      {{ ga4.unnest_key('event_params', 'video_provider') }},
      {{ ga4.unnest_key('event_params', 'vide_title') }},
      {{ ga4.unnest_key('event_params', 'visible') }}
      {% if var("video_start_custom_parameters", "none") != "none" %}
        {{ stage_custom_parameters( var("video_start_custom_parameters") )}}
      {% endif %}
 from {{ref('stg_ga4__events')}}    
 where event_name = 'video_start'
)

select * from video_start_with_params