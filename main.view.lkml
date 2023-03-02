# Copyright 2023 Cold Bore Capital Management, LLC
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
# documentation files (the "Software"), to deal in the Software without restriction, including without
# limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
# Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions
# of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
# TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
# CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.



view: main {

  extension: required


# *************************
# Filters / Parameters
# *************************

# ******
## Tile or Dashboard Filters

  parameter: as_of_date {
    label: "As of Date"
    description: "Use this to change the value of the current date. Setting to a date will change the tile/dashboard to act as if today is the selected date."
    type: date
    group_label: "Tile or Dashboard Filters"
    view_label: "@{period_control_group_title}"
  }

  parameter: size_of_range {
    alias: [user_size_of_range]
    description: "How many days in your period? Only applies to the Trailing option of the Period Selection parameter."
    label: "Number of Trailing Days"
    group_label: "Tile or Dashboard Filters"
    view_label: "@{period_control_group_title}"
    type: unquoted
    allowed_value: {
      label: "Select"
      value: "0"
    }
    allowed_value: {value: "1"}
    allowed_value: {value: "2"}
    allowed_value: {value: "5"}
    allowed_value: {value: "7"}
    allowed_value: {value: "14"}
    allowed_value: {value: "21"}
    allowed_value: {value: "28"}
    allowed_value: {value: "30"}
    allowed_value: {value: "42"}
    allowed_value: {value: "49"}
    allowed_value: {value: "56"}
    allowed_value: {value: "63"}
    allowed_value: {value: "70"}
    allowed_value: {value: "77"}
    allowed_value: {value: "84"}
    allowed_value: {value: "91"}
    allowed_value: {value: "180"}
    allowed_value: {value: "273"}
    allowed_value: {value: "365"}
    allowed_value: {value: "730"}
    default_value: "0"

  }

  parameter: exclude_days {
    alias: [user_exclude_days]
    description: "Allows for an exclusion of the current date, two days ago, last data found in the table, or the last completed week, month, quarter, year."
    label: "Exclude Days"
    group_label: "Tile or Dashboard Filters"
    view_label: "@{period_control_group_title}"
    type: unquoted
    allowed_value: {
      label: "No Exclude"
      value: "0"
    }
    allowed_value: {
      label: "Exclude Current Day"
      value: "1"
    }
    allowed_value: {
      label: "Exclude Yesterday"
      value: "2"
    }
    allowed_value: {
      label: "Last Data - Including Future"
      value: "last_data_future"
    }
    allowed_value: {
      label: "Last Data - Max Today "
      value: "last_data_max_today"
    }
    allowed_value: {
      label: "End of Last Full Week"
      value: "last_full_week"
    }
    allowed_value: {
      label: "End of Last Full Month"
      value: "last_full_month"
    }
    allowed_value: {
      label: "End of Last Full Quarter"
      value: "last_full_quarter"
    }
    allowed_value: {
      label: "End of Last Full Year"
      value: "last_full_year"
    }
    default_value: "0"
  }

  parameter: period_selection {
    alias: [user_compare_to, compare_to, user_period_selection]
    label: "Period Selection"
    view_label: "@{period_control_group_title}"
    group_label: "Tile or Dashboard Filters"
    type: unquoted
    allowed_value: {
      label: "Select a Timeframe"
      value: "none"
    }
    allowed_value: {
      label: "Trailing"
      value: "trailing"
    }
    allowed_value: {
      label: "Week to Date"
      value: "wtd"
    }
    allowed_value: {
      label: "Month to Date"
      value: "mtd"
    }
    allowed_value: {
      label: "Quarter to Date"
      value: "qtd"
    }
    allowed_value: {
      label: "Year to Date"
      value: "ytd"
    }
    allowed_value: {
      label: "Last Full Week"
      value: "lw"
    }
    allowed_value: {
      label: "Last Full Month"
      value: "lm"
    }
    allowed_value: {
      label: "Last Full Quarter"
      value: "lq"
    }
    allowed_value: {
      label: "Last Full Year"
      value: "ly"
    }
    default_value: "none"
  }

  parameter: compare_to_period {
    alias: [pop_selection]
    label: "Compare To"
    view_label: "@{period_control_group_title}"
    group_label: "Tile or Dashboard Filters"
    type: unquoted
    allowed_value: {
      label: "Select a Period"
      value: "none"
    }
    allowed_value: {
      label: "Prior Period (Trailing)"
      value: "prior_period"
    }
    allowed_value: {
      label: "Prior Week"
      value: "prior_week"
    }
    allowed_value: {
      label: "Prior Month"
      value: "prior_month"
    }
    allowed_value: {
      label: "Prior Quarter"
      value: "prior_quarter"
    }
    allowed_value: {
      label: "Prior Year"
      value: "prior_year"
    }
    default_value: "none"
  }

  parameter: debug {
    label: "Debug Mode"
    group_label: "Tile Only Filters"
    view_label: "@{period_control_group_title}"
    type: yesno
    default_value: "no"
  }

  # ******
  ## Tile Only Filters

  parameter: period_count {
    alias: [comparison_periods, period_size]
    label: "Number of Periods"
    group_label: "Tile Only Filters"
    view_label: "@{period_control_group_title}"
    description: "Selects the number of days in the period."
    type: number
    allowed_value: {
      label: "Select"
      value: "1"
    }
    allowed_value: {value: "2"}
    allowed_value: {value: "3"}
    allowed_value: {value: "4"}
    allowed_value: {value: "5"}
    allowed_value: {value: "6"}
    allowed_value: {value: "7"}
    allowed_value: {value: "8"}
    allowed_value: {value: "9"}
    allowed_value: {value: "10"}
    allowed_value: {value: "11"}
    allowed_value: {value: "12"}
    allowed_value: {value: "13"}
    allowed_value: {value: "14"}
    allowed_value: {value: "15"}
    allowed_value: {value: "16"}
    allowed_value: {value: "17"}
    allowed_value: {value: "18"}
    allowed_value: {value: "19"}
    allowed_value: {value: "20"}
    allowed_value: {value: "21"}
    allowed_value: {value: "22"}
    allowed_value: {value: "23"}
    allowed_value: {value: "24"}
    allowed_value: {value: "25"}
    allowed_value: {value: "26"}
    allowed_value: {value: "27"}
    allowed_value: {value: "28"}
    allowed_value: {value: "29"}
    allowed_value: {value: "31"}
    allowed_value: {value: "32"}
    allowed_value: {value: "33"}
    allowed_value: {value: "34"}
    allowed_value: {value: "35"}
    allowed_value: {value: "36"}
    allowed_value: {value: "37"}
    allowed_value: {value: "38"}
    allowed_value: {value: "39"}
    allowed_value: {value: "40"}
    allowed_value: {value: "41"}
    allowed_value: {value: "42"}
    allowed_value: {value: "43"}
    allowed_value: {value: "44"}
    allowed_value: {value: "45"}
    allowed_value: {value: "46"}
    allowed_value: {value: "47"}
    allowed_value: {value: "48"}
    allowed_value: {value: "49"}
    allowed_value: {value: "50"}
    allowed_value: {value: "51"}
    allowed_value: {value: "52"}
    allowed_value: {value: "53"}
    default_value: "1"
  }

  parameter: display_dates_in_period_labels {
    alias: [display_dates_in_trailing_periods]
    group_label: "Tile Only Filters"
    view_label: "@{period_control_group_title}"
    description: "Display the dates alongside the periods. For example 'Current Period - 2021-01-01 to 2021-04-01'. Note that this will cause any custom colors set for the series to break when the dates change (i.e. the next day)."
    type: yesno
    default_value: "No"
  }

  parameter: snap_start_date_to {
    # The period control block is designed to be used at a dashboard level with tiles that compare period over period, and tiles that just display normal date
    # ranges. The snap function ensures that a chart or table displaying a day, week, month, quarter, or year, is actually displaying the full date range. The
    # effect of this parameter is to add a date_trunc('{snap value}', start_date) type function to the start date, thereby ensuring that the start date is the
    # true expected start of the range.
    alias: [user_snap_start_date_to, tile_snap_start_date_to]
    label: "Snap Start Date to"
    description: "Setting this filter will ensure that the start date includes the begining of the selected period. For example, if you selected trailing 365, the first month might be partial. Selecting snap to month would ensure a complete first month. Cannot be used with period over period."
    view_label: "@{period_control_group_title}"
    group_label: "Tile Only Filters"
    type: unquoted
    allowed_value: {
      label: "Select a Snap Type"
      value: "none"
    }
    allowed_value: {
      label: "Week"
      value: "week"
    }
    allowed_value: {
      label: "Month"
      value: "month"
    }
    allowed_value: {
      label: "Quarter"
      value: "quarter"
    }
    allowed_value: {
      label: "Year"
      value: "year"
    }
    default_value: "none"
  }


  # *************************
  # Date manipulation fields
  # *************************

  dimension: event_date_tz_convert {
    ##
    # Converts the event date to the proper timezone if tz conversion is specified.
    #
    # Looker converts any date with time to a string using a TO_CHAR function. This make dealing with any sort of timezone conversion using the
    # naitive Looker based convert_tz: yes type parameter really difficult to work with and results in needing to re-cast a string date to time.
    # To avoid this additional complexity, this function handles the conversion of the timezone if specified by the "convert_tz" parameter in
    # the consuming view.
    #
    # Within the consuming view, there is a parameter named "convert_tz". If the date in use is only a date, this must be set to "no". If the date in
    # use contains a time, then the parameter should be set to yes.
    hidden: yes
    type: date_raw
    convert_tz: no
    sql:
      {%- if convert_tz._parameter_value == 'true' -%}
        {%- case '@{database_type}' -%}
          {%- when "big_query" -%}  datetime(${event_date}, '{{ _query._query_timezone }}')
          {%- else -%}  convert_timezone('@{database_time_zone}', '{{ _query._query_timezone }}', ${event_date})
        {%- endcase -%}
      {%- else -%}
        ${event_date}
      {%- endif -%};;
  }



  dimension: getdate_func {
    ##
    # Returns the value of the current date from Redshift with any timezone conversion added.
    #
    # It's important that the timezone conversion of "current date" only occurs once. This dimension is used by other dimensions to set the
    # current date. The current_date function from Redshift can't be used here as timezone conversions on a date only data type result in really bad stuff.
    hidden: yes
    type: date_raw
    sql:
    {%- if _query._query_timezone != '@{database_time_zone}' -%}

        {%- case '@{database_type}' -%}
          {%- when "redshift" -%} convert_timezone('@{database_time_zone}', '{{ _query._query_timezone }}', getdate())
          {%- when "snowflake" -%} convert_timezone('@{database_time_zone}', '{{ _query._query_timezone }}', current_timestamp)
          {%- when "bigquery" %} datetime(current_timestamp(), '{{ _query._query_timezone }}')
        {%- endcase -%}

    {%- else -%}
        {%- case '@{database_type}' -%}
          {%- when "redshift" -%} getdate()
          {%- when "snowflake" -%} current_timestamp
          {%- when "bigquery" %} datetime(current_timestamp())
        {%- endcase -%}
    {%- endif -%};;
    convert_tz: no
  }

  dimension: end_date_dim_as_of_mod {
    ##
    # Substitutes an "as of date" selection, and shifts the end date such that it is one second before midnight.
    #
    # This dimension performes two key operations:
    # 1. If an as of date is selected, it subs that instead of the real date.
    # 2. It converts the date to one second before midnight. For example, if getdate() returns 2022-01-01 05:03:00, it will first be converted to 2022-01-01 00:00:00, then
    #    converted to 2022-01-01 23:59:59 so that the full day is included in the range.
    #
    # Note, if exclude days is used, no modification of seconds is made. This will be handled in the end_date_dim dimension.
    hidden: yes
    type: date_raw
    sql:
      {%- if as_of_date._parameter_value == 'NULL' and exclude_days._parameter_value == '0' -%}
        {%- case '@{database_type}' -%}
          {%- when "bigquery" %} date_add(date_trunc(${getdate_func}, DAY), interval 86399 second)
          {%- else -%} date_add('seconds', 86399, date(${getdate_func}))
        {%- endcase %}

      {%- elsif as_of_date._parameter_value == 'NULL' and exclude_days._parameter_value != '0' -%}
          ${getdate_func}
      {%- else -%}
        {%- case '@{database_type}' -%}
          {%- when "bigquery" %} date_add({%- parameter as_of_date -%}, interval 86399 second))
          {%- else -%} date_add('seconds', 86399, {%- parameter as_of_date -%})
        {%- endcase %}

      {%- endif -%};;
    convert_tz: no
  }

  dimension: end_date_dim {
    ##
    # Applies any "exclude days" selection to end date value.
    #
    # @todo: Will convert_timezone always be needed on the max origin date function?
    type: date_raw
    convert_tz: no
    hidden:  yes
    sql:{%- if period_selection._parameter_value == 'lw' or period_selection._parameter_value == 'lm'
               or period_selection._parameter_value == 'lq' or period_selection._parameter_value == 'ly' -%}
            {%- case period_selection._parameter_value -%}
                {%- when 'lw' -%}
                    {%- case '@{database_type}' -%}
                      {%- when "bigquery" %} date_add(date_trunc(${end_date_dim_as_of_mod}, WEEK), interval -1 second))
                      {%- else %} date_add('seconds', -1, date_trunc('week', ${end_date_dim_as_of_mod}))
                    {%- endcase %}
                {%- when 'lm' -%}
                    {%- case '@{database_type}' -%}
                      {%- when "bigquery" %} date_add(date_trunc(${end_date_dim_as_of_mod}, MONTH), interval -1 second))
                      {%- else -%} date_add('seconds', -1, date_trunc('month', ${end_date_dim_as_of_mod}))
                    {%- endcase %}
                {%- when 'lq' -%}
                    {%- case '@{database_type}' -%}
                      {%- when "bigquery" %} date_add(date_trunc(${end_date_dim_as_of_mod}, QUARTER), interval -1 second))
                      {%- else -%} date_add('seconds', -1, date_trunc('quarter', ${end_date_dim_as_of_mod}))
                    {%- endcase %}
                {%- when 'ly' -%}
                    {%- case '@{database_type}' -%}
                      {%- when "bigquery" %} date_add(date_trunc(${end_date_dim_as_of_mod}, YEAR), interval -1 second))
                      {%- else -%} date_add('seconds', -1, date_trunc('year', ${end_date_dim_as_of_mod}))
                    {%- endcase %}
            {%- endcase %}
        {%- else -%}
          {%- if as_of_date._parameter_value == 'NULL' and exclude_days._parameter_value != '0' -%}
            {%- case exclude_days._parameter_value -%}
             {%- when "last_data_future" -%}
                {%- if convert_tz._parameter_value == 'true' -%}
                    {%- case '@{database_type}' -%}
                      {%- when "bigquery" %} datetime(date_add(date_trunc((select max(${origin_event_date}) from ${origin_table_name}), DAY), interval 86399 second), '{{ _query._query_timezone }}')
                      {%- else -%} convert_timezone('@{database_time_zone}', '{{ _query._query_timezone }}', date_add('seconds', 86399, date((select max(${origin_event_date}) from ${origin_table_name}))))
                    {%- endcase %}

                {%- else -%}
                {%- case '@{database_type}' -%}
                  {%- when "big_query" -%}  date_add(date_trunc((select max(${origin_event_date}) from ${origin_table_name}), DAY), interval 86399 SECOND)
                  {%- else -%}  date_add('seconds', 86399, date((select max(${origin_event_date}) from ${origin_table_name})))
                {%- endcase -%}

                {%- endif -%}
             {% - when "last_data_max_today" -%}
                {%- if convert_tz._parameter_value == 'true' -%}

                    {%- case '@{database_type}' -%}
                      {%- when "bigquery" %} datetime(date_add(date_trunc(least(${getdate_func},(select max(${origin_event_date}) from ${origin_table_name})), DAY), interval 86399 second), '{{ _query._query_timezone }}')
                      {%- else -%} convert_timezone('@{database_time_zone}', '{{ _query._query_timezone }}', date_add('seconds', 86399, date(least(${getdate_func},(select max(${origin_event_date}) from ${origin_table_name})))))
                    {%- endcase %}

                {%- else -%}
                  {%- case '@{database_type}' -%}
                    {%- when "bigquery" %} date_add(date_trunc(least(${getdate_func},(select max(${origin_event_date}) from ${origin_table_name})), DAY), interval 86399 second)
                    {%- else -%} date_add('seconds', 86399, date(least(${getdate_func},(select max(${origin_event_date}) from ${origin_table_name}))))
                  {%- endcase %}

                {%- endif -%}
             {%- when "1" -%}
                {%- case '@{database_type}' -%}
                  {%- when "bigquery" %} date_add(date_trunc(${end_date_dim_as_of_mod}, DAY), interval -1 SECOND)
                  {%- else %} date_add('seconds', -1, date(${end_date_dim_as_of_mod}))
                {%- endcase %}

             {%- when "2" -%}
                {%- case '@{database_type}' -%}
                  {%- when "bigquery" %} date_add(date_trunc(${end_date_dim_as_of_mod}, DAY), interval -86401 SECOND)
                  {%- else %} date_add('seconds', -86401, date(${end_date_dim_as_of_mod}))
                {%- endcase %}

             {%- when "last_full_week" -%}
                {%- case '@{database_type}' -%}
                  {%- when "bigquery" %} date_add(date_trunc(${end_date_dim_as_of_mod}, WEEK), interval -1 SECOND)
                  {%- else %} date_add('seconds', -1, date_trunc('week', ${end_date_dim_as_of_mod}))
                {%- endcase %}

             {%- when "last_full_month" -%}
                {%- case '@{database_type}' -%}
                  {%- when "bigquery" %} date_add(date_trunc(${end_date_dim_as_of_mod}, MONTH), interval -1 SECOND)
                  {%- else %} date_add('seconds', -1, date_trunc('month', ${end_date_dim_as_of_mod}))
                {%- endcase %}
             {%- when "last_full_quarter" -%}
                {%- case '@{database_type}' -%}
                  {%- when "bigquery" %} date_add(date_trunc(${end_date_dim_as_of_mod},QUARTER), interval -1 SECOND)
                  {%- else %} date_add('seconds', -1, date_trunc('quarter', ${end_date_dim_as_of_mod}))
                {%- endcase %}
             {%- when "last_full_year" -%}
                {%- case '@{database_type}' -%}
                  {%- when "bigquery" %} date_add(date_trunc(${end_date_dim_as_of_mod},YEAR), interval -1 SECOND)
                  {%- else %} date_add('seconds', -1, date_trunc('year', ${end_date_dim_as_of_mod}))
                {%- endcase %}
             {%- else -%}
                ${end_date_dim_as_of_mod}
            {%- endcase %}
          {%- else -%}
            ${end_date_dim_as_of_mod}
          {%- endif -%}
        {%- endif -%}
        ;;
  }

  dimension: days_between_last_data_and_current {
    # The goal here is to get an offset from current date to last data date as a number, and pass that into the date_add function. This is a bit complex, but
    # it works.

    hidden: yes
    sql:
    {%- if convert_tz._parameter_value == 'true' -%}
      {%- case '@{database_type}' -%}
        {%- when "bigquery" %} date_diff(datetime((select max(${origin_event_date}) from ${origin_table_name}), '{{ _query._query_timezone }}'), current_date, DAY)
        {%- else %} date_diff('days', convert_timezone('@{database_time_zone}', '{{ _query._query_timezone }}', (select max(${origin_event_date}) from ${origin_table_name})), current_date)
      {%- endcase %}
    {%- else -%}
      {%- case '@{database_type}' -%}
        {%- when "bigquery" %} date_diff((select max(${origin_event_date}) from ${origin_table_name}), current_date, DAY)
        {%- else %} date_diff('days', (select max(${origin_event_date}) from ${origin_table_name}), current_date)
      {%- endcase %}
    {%- endif -%} ;;
  }

  dimension: start_date {
    # The end date used / displayed by the Looker Period Control block is inclusive. This means that while a normal date subtraction operation like date_add('days', -30, '2022-05-31') would
    # result in a date of 2022-05-01, that's not the expected outcome. In reality, the displayed date 2022-05-31 is 2022-05-31 23:59:59. To account for this, the date function is truncated,
    # and a day is added to the start date.
    hidden: yes
    sql:
      {%- if as_of_date._parameter_value == 'NULL' -%}
          {%- if period_selection._parameter_value == 'trailing' -%}
            {%- case '@{database_type}' -%}
              {%- when "bigquery" %} date_add(date_trunc(${getdate_func}, DAY), interval 1 day)
              {%- else %} date_add('days', 1, date(${getdate_func}))
            {%- endcase -%}
          {%- else -%}
            {%- case '@{database_type}' -%}
              {%- when "big_query" -%}  date_trunc(${getdate_func}, DAY)
              {%- else -%}  date(${getdate_func})
            {%- endcase -%}

          {%- endif -%}
      {%- else -%}
          {%- if period_selection._parameter_value == 'trailing' -%}
            {%- case '@{database_type}' -%}
              {%- when "bigquery" %} date_add({%- parameter as_of_date -%}, interval 1 day)
              {%- else %} date_add('days', 1, {%- parameter as_of_date -%})
            {%- endcase -%}
          {%- else -%}
            {%- case '@{database_type}' -%}
              {%- when "big_query" -%}  date_trunc({%- parameter as_of_date -%}, DAY)
              {%- else -%}  date({%- parameter as_of_date -%})
            {%- endcase -%}
          {%- endif -%}
      {%- endif -%};;
  }

  dimension: start_date_post_exclude {
    # Applies any exclude days offset to the start date
    #
    # @todo NEED TO TEST THE LAST FULL WEEK, MONTH, SO ON PART OF THIS.
    hidden: yes
    sql: {%- if as_of_date._parameter_value == 'NULL' and exclude_days._parameter_value != '0' -%}
            {%- case exclude_days._parameter_value -%}
             {%- when "last_data_future" -%}
                {%- case '@{database_type}' -%}
                  {%- when "bigquery" %} date_add(${start_date}, interval -${days_between_last_data_and_current} DAY)
                  {%- else %} date_add('days', -${days_between_last_data_and_current}, ${start_date})
                {%- endcase %}
             {%- when "1" -%}
                {%- case '@{database_type}' -%}
                  {%- when "bigquery" %} date_add(${start_date}, interval -1 DAY)
                  {%- else %} date_add('days', -1, ${start_date})
                {%- endcase %}
             {%- when "2" -%}
                {%- case '@{database_type}' -%}
                  {%- when "bigquery" %} date_add(${start_date}, interval -2 DAY)
                  {%- else -%} date_add('days', -2, ${start_date})
                {%- endcase %}
             {%- when "last_full_week" -%}
                ${end_date_dim}
             {%- when "last_full_month" -%}
                ${end_date_dim}
             {%- when "last_full_quarter" -%}
                ${end_date_dim}
             {%- when "last_full_year" -%}
                ${end_date_dim}
             {%- else -%}
                ${start_date}
            {%- endcase %}
          {%- else -%}
            ${start_date}
          {%- endif -%}
          ;;
  }

  dimension: start_date_dim {
    ##
    # This dimension handles any date truncation needed for WTD, MTD, YTD type operations.
    #
    # The start_date_dim will be used as the starting date for start period date calcs. When a {x}td type seletion is made, the period size will
    # be set to zero, relying on the date trunc operation to set the start date of the period.
    #
    # Notes:
    #   1. The else case handles trailing selection
    hidden: yes
    type: date_raw
    convert_tz: no
    sql:
        {%- case period_selection._parameter_value -%}
            {%- when 'wtd' -%}
              {%- case '@{database_type}' -%}
                {%- when "bigquery" %} datetime(date_trunc(${start_date_post_exclude}, WEEK))
                {%- else %} date_trunc('w', ${start_date_post_exclude})
              {%- endcase %}
            {%- when 'mtd' -%}
              {%- case '@{database_type}' -%}
                {%- when "bigquery" %} datetime(date_trunc(${start_date_post_exclude}, MONTH))
                {%- else %} date_trunc('mon', ${start_date_post_exclude})
              {%- endcase %}
            {%- when 'qtd' -%}
              {%- case '@{database_type}' -%}
                {%- when "bigquery" %} datetime(date_trunc(${start_date_post_exclude}, QUARTER))
                {%- else %} date_trunc('qtrs', ${start_date_post_exclude})
              {%- endcase %}
            {%- when 'ytd' -%}
              {%- case '@{database_type}' -%}
                {%- when "bigquery" %} datetime(date_trunc(${start_date_post_exclude}, YEAR))
                {%- else %} date_trunc('y', ${start_date_post_exclude})
              {%- endcase %}
            {%- when 'lw' -%}
              {%- case '@{database_type}' -%}
                {%- when "bigquery" %} datetime(date_trunc(date_add(${start_date_post_exclude}, interval - 1 WEEK), WEEK))
                {%- else %} date_trunc('w', date_add('w', -1, ${start_date_post_exclude}))
              {%- endcase %}
            {%- when 'lm' -%}
              {%- case '@{database_type}' -%}
                {%- when "bigquery" %} datetime(date_trunc(date_add(${start_date_post_exclude}, interval -1 MONTH), MONTH))
                {%- else %} date_trunc('mon', date_add('mon', -1, ${start_date_post_exclude}))
              {%- endcase %}
            {%- when 'lq' -%}
              {%- case '@{database_type}' -%}
                {%- when "bigquery" %} datetime(date_trunc(date_add(${start_date_post_exclude}, interval -1 QUARTER), QUARTER))
                {%- else %} date_trunc('qtrs', date_add('qtrs', -1, ${start_date_post_exclude}))
              {%- endcase %}
            {%- when 'ly' -%}
              {%- case '@{database_type}' -%}
                {%- when "bigquery" %} datetime(date_trunc(date_add(${start_date_post_exclude}, interval -1 YEAR), YEAR))
                {%- else %} date_trunc('y', date_add('y', -1, ${start_date_post_exclude}))
              {%- endcase %}
            {%- else -%}
                ${start_date_post_exclude}
         {%- endcase %}
        ;;
  }

  # allowed_value: {
  #   label: "Last Full Week"
  #   value: "lw"
  # }
  # allowed_value: {
  #   label: "Last Full Month"
  #   value: "lm"
  # }
  # allowed_value: {
  #   label: "Last Full Quarter"
  #   value: "lq"
  # }
  # allowed_value: {
  #   label: "Last Full Year"
  #   value: "ly"
  # }


  # *************************
  # Size of Range and Period
  # *************************

  dimension: period_name_selection {
    hidden: yes
    sql: {%- case period_selection._parameter_value -%}
              {%- when "trailing" -%} 'Period'
              {%- when "wtd" or "lw" -%} 'Week'
              {%- when "mtd" or "lm" -%} 'Month'
              {%- when "qtd" or "lq" -%} 'Quarter'
              {%- when "ytd" or "ly" -%} 'Year'
           {%- endcase %};;
  }

  dimension: invalid_state_warning {
    description: "This can be used on a dashboard to indicate to the user where an invalid filter selection state exists."
    view_label: "@{period_control_group_title}"
    label: "Filter Warning Block"
    group_label: "Display Blocks"
    type: string
    sql:{%- assign _period_selection = period_selection._parameter_value -%}
        {%- assign _compare_to_period = compare_to_period._parameter_value -%}
        {%- assign _range_size = size_of_range._parameter_value | times: 1 -%}
        {%- if _compare_to_period == 'prior_week' and _range_size > 7 and _period_selection == 'trailing' %}
            'ERROR: Cannot compare prior week over 7 days. {{_range_size}} days selected.'
        {%- elsif (_compare_to_period == 'prior_month' and _range_size > @{days_in_standard_month} and _period_selection == 'trailing') %}
            'ERROR: Cannot compare prior month over @{days_in_standard_month} days. {{_range_size}} days selected.'
        {%- elsif (_compare_to_period == 'prior_quarter' and _range_size > @{days_in_standard_quarter} and _period_selection == 'trailing') %}
            'ERROR: Cannot compare prior quarter over @{days_in_standard_quarter} days. {{_range_size}} days selected.'
        {%- elsif (_compare_to_period == 'prior_year' and _range_size > 365 and _period_selection == 'trailing') %}
            'ERROR: Cannot compare prior year over 365 days. {{_range_size}} days selected.'
        {%- elsif (_period_selection == 'wtd' or _period_selection == 'mtd' or _period_selection == 'qtd' or _period_selection == 'ytd'
           or _period_selection == 'lw' or _period_selection == 'lm'  or _period_selection == 'lq' or _period_selection == 'ly')
           and _compare_to_period == 'prior_period' %}
            'ERROR: Cannot use {{_period_selection}} with a Prior Period compare to selection'
        {%- elsif (_period_selection == 'lq' or _period_selection == 'ly') and (_compare_to_period == 'prior_month' or _compare_to_period == 'prior_week') -%}
            'ERROR: Cannot use last quarter or last year with a compare to of prior month or week.'

        {%- elsif _period_selection == 'ly' and (_compare_to_period == 'prior_month' or _compare_to_period == 'prior_week' or _compare_to_period == 'prior_quarter') -%}
            'ERROR: Cannot use last full year with a compare to of prior quarter, month, or week.'
        {%- elsif _period_selection == 'mtd' and _compare_to_period == 'prior_week' %}
            'ERROR: Cannot use Month to Date with a Prior Week compare to selection'
        {%- elsif _period_selection == 'qtd' and (_compare_to_period == 'prior_week' or _compare_to_period == 'prior_month') %}
            'ERROR: Cannot use Quarter to Date with a Prior Week or Prior Month compare to selection'
        {%- elsif _period_selection == 'ytd' and (_compare_to_period == 'prior_week' or _compare_to_period == 'prior_month' or _compare_to_period == 'prior_quarter') %}
            'ERROR: Cannot use Year to Date can only be used with a Prior Year compare to selection'
        {%- elsif snap_start_date_to._parameter_value != 'none' and compare_to_period._parameter_value != 'none' -%}
            'ERROR: Invalid state, you cannot use snap feature with a compare period'
        {%- else -%}
            ''
        {%- endif -%};;
  }

  # *************************************************************************************
  # Period Block
  # *************************************************************************************

  dimension: period {
    view_label: "@{period_control_group_title}"
    label: "Period"
    group_label: "Pivot Dimensions"
    type: string
    order_by_field: order_for_period
    # Notes:
    # 1. Invalid Date and Duration Combinations | The first portion of this script checks to make sure the user hasn't selected a combo of
    #    trailing or other durations that would cause overlap. If comparing week over week, the max trailing is 7. For month 28, quarter 90,
    #    and year 365.
    #
    # 2. Usage of times: 1 | This is used to convert the value from a string to a number. By default all values in Liquid are strings. Numeric
    #    comparison can't happen with a string. This trick converts the value to an int or a float. | floor is used if conversion to a float occurs
    #    when it's unwanted.
    #
    # 3. _additional_days | This is needed for selections like yesterday. An additional day is needed with a period size of 1 in the second loop,
    #                   or the day count will be short by 1. Default is zero, the value is only set when yesterday is selected.
    #
    # 4. Minus 1 on range end | -{{- _range_end | minus: 1 -}} The minus 1 is needed here to align the range sizes. If you were using a 7 day period for example,
    #    you want date_add('days', -6, end_date).
    #
    sql:
    case when ${invalid_state_warning} <> '' then ${invalid_state_warning} else
        {%- assign _period_selection = period_selection._parameter_value -%}
        {%- assign _compare_to_period = compare_to_period._parameter_value -%}
        {%- assign _range_size = size_of_range._parameter_value | times: 1 -%}
        {%- assign _range_start = _range_size | times: 1 -%}
        {%- assign _range_end = 0 -%}
        {%- assign _additional_days = 0 -%}

        {%- assign _period_count_values = "1st,2nd,3rd,4th,5th,6th,7th,8th,9th,10th,11th,12th,13th,14th,15th,16th,17th,18th,19th,20th,21st,22nd,23rd,24th,25th,26th,27th,28th,29th,30th,31st,32nd,33rd,34th,35th,36th,37th,38th,39th,40th,41st,42nd,43rd,44th,45th,46th,47th,48th,49th,50th,51st,52nd,53rd" | split: ',' %}

        {%- if period_selection._parameter_value == "wtd" or period_selection._parameter_value == "mtd" or period_selection._parameter_value == "qtd"
            or period_selection._parameter_value == "ytd" or period_selection._parameter_value == "lw" or period_selection._parameter_value == "lm"
            or period_selection._parameter_value == "lq" or period_selection._parameter_value == "ly" -%}
            {%- assign _range_size = 0 -%}
            {%- assign _range_start = 0 -%}
            {%- assign _range_end = 0 -%}
            {%- assign _additional_days = 0 %}
        {%- endif -%}

        {%- assign _period_count = period_count._parameter_value | times: 1 %}
        case
        {% for i in (1.._period_count) -%}
          {%- assign _zero_index = i | minus: 1 -%}
          {%- assign _period_prefix = _period_count_values[_zero_index] -%}
          {%- assign _period_suffix = 'Period' -%}
          {%- assign _period_name = "'" | append: _period_prefix | append: " " | append: _period_suffix | append: "'" -%}
          {%- if i == 1 -%}
               when ${event_date_tz_convert} between
                {%- case '@{database_type}' -%}
                  {%- when "bigquery" %} date_add(${start_date_dim}, interval -{{ _range_start }} DAY)
                  {%- else %}  date_add('days', -{{- _range_start -}}, ${start_date_dim})
                {%- endcase %}
               and
                {%- case '@{database_type}' -%}
                  {%- when "bigquery" %} date_add(${end_date_dim}, interval -{{- _range_end }} DAY)
                  {%- else %} date_add('days', -{{- _range_end -}}, ${end_date_dim})
                {%- endcase %}
                  then {{ _period_name }}

               {%- if display_dates_in_period_labels._parameter_value == 'true' -%}
                  {%- case '@{database_type}' -%}
                    {%- when "bigquery" %} || ' (' || format_date('@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}', date_add(${start_date_dim}, interval -{{ _range_start }} DAY))
                    {%- else %} || ' (' || to_char(date_add('days', -{{- _range_start -}}, ${start_date_dim}), '@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}')
                  {%- endcase %}
                  {%- if _range_size != 1 -%}
                    {%- case '@{database_type}' -%}
                      {%- when "bigquery" %} || ' to ' || format_date('@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}', date_add(${end_date_dim}, interval -{{ _range_end }} DAY))
                      {%- else %} || ' to ' || to_char(date_add('days', -{{- _range_end -}}, ${end_date_dim}), '@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}')
                    {%- endcase %}
                  {%- endif %} || ')'
               {%- endif -%}
          {%- endif -%}

          {%- if i != 1 %}
            {%- case _compare_to_period %}
              {%- when 'prior_period' %}
                  when ${event_date_tz_convert} between
                    {%- case '@{database_type}' -%}
                      {%- when "bigquery" %} date_add(${start_date_dim}, interval -{{ _range_start }} DAY) and date_add(${end_date_dim}, interval -{{ _range_end | minus: 1 }} DAY)
                      {%- else %} date_add('days', -{{- _range_start -}}, ${start_date_dim}) and date_add('days', -{{- _range_end | minus: 1 -}}, ${end_date_dim})
                    {% endcase -%}
                     then {{ _period_name }}

                {%- if display_dates_in_period_labels._parameter_value == 'true' -%}
                    {%- case '@{database_type}' -%}
                      {%- when "bigquery" %} || ' (' || format_date('@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}', date_add(${start_date_dim}, interval -{{ _range_start }} DAY))
                      {%- else %}  || ' (' || to_char(date_add('days', -{{- _range_start -}}, ${start_date_dim}), '@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}')
                    {%- endcase %}

                    {%- if _range_size != 1 -%}
                    {%- case '@{database_type}' -%}
                      {%- when "bigquery" %} || ' to ' || format_date('@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}', date_add(${end_date_dim}, interval -{{ _range_end | minus: 1 }} DAY))
                      {%- else %} || ' to ' || to_char(date_add('days', -{{- _range_end | minus: 1 -}}, ${end_date_dim}), '@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}')
                    {%- endcase %}

                    {%- endif %} || ')'
                {%- endif -%}

              {%- when 'prior_week' %}
                  when ${event_date_tz_convert} between
                  {%- case '@{database_type}' -%}
                    {%- when "bigquery" %} date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} WEEK) and date_add(date_add(${end_date_dim}, interval -{{ _range_end }} DAY), interval -{{ i | minus: 1}} DAY)
                    {%- else %} date_add('w',   -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('w',   -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim}))
                  {%- endcase %}
                  then {{ _period_name }}

                {%- if display_dates_in_period_labels._parameter_value == 'true' -%}
                  {%- case '@{database_type}' -%}
                    {%- when "bigquery" %} || ' (' || format_date('@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}', date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} WEEK))
                    {%- else %} || ' (' || to_char(date_add('w',   -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})), '@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}')
                  {%- endcase %}

                    {%- if _range_size != 1 -%}
                      {%- case '@{database_type}' -%}
                        {%- when "bigquery" %} || ' to ' || format_date('@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}', date_add(date_add(${end_date_dim}, interval -{{ _range_end }} DAY), interval  -{{- i | minus: 1}} WEEK))
                        {%- else %} || ' to ' || to_char(date_add('w',   -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})), '@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}')
                      {%- endcase %}
                    {%- endif %} || ')'
                {%- endif -%}

              {%- when 'prior_month' %}
                  when ${event_date_tz_convert} between
                    {%- case '@{database_type}' -%}
                      {%- when "bigquery" %} date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} MONTH) and date_add(date_add(${end_date_dim}, interval -{{ _range_end }} day), interval -{{ i | minus: 1}} MONTH)
                      {%- else %} date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim}))
                    {%- endcase %}
                    then '{{ _period_prefix | append: " " | append: _period_suffix }}'

                  {%- if display_dates_in_period_labels._parameter_value == 'true' -%}
                    {%- case '@{database_type}' -%}
                      {%- when "bigquery" %} || ' (' || format_date('@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}', date_add(date_add(${start_date_dim}, interval -{{- _range_start }} DAY), interval -{{ i | minus: 1}} MONTH))
                      {%- else %} || ' (' || to_char(date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) , '@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}')
                    {%- endcase %}

                    {%- if _range_size != 1 -%}
                      {%- case '@{database_type}' -%}
                        {%- when "bigquery" %} || ' to ' || format_date('@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}', date_add(date_add(${end_date_dim}, interval -{{ _range_end }} DAY), interval -{{ i | minus: 1}} MONTH))
                        {%- else %} || ' to ' || to_char(date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) , '@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}')
                      {%- endcase %}

                    {%- endif %} || ')'
                  {%- endif -%}

              {%- when 'prior_quarter' %}
                  when ${event_date_tz_convert} between
                    {%- case '@{database_type}' -%}
                      {%- when "bigquery" %} date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} quarter)  and date_add(date_add('days', -{{- _range_end -}}, ${end_date_dim}), interval -{{ i | minus: 1}} QUARTER)
                      {%- else %} date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim}))  and date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim}))
                    {%- endcase %}
                     then '{{ _period_prefix | append: " " | append: _period_suffix }}'
                  {%- if display_dates_in_period_labels._parameter_value == 'true' -%}
                    {%- case '@{database_type}' -%}
                      {%- when "bigquery" %} || ' (' || format_date('@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}', date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} QUARTER))
                      {%- else %} || ' (' || to_char(date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) , '@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}')

                    {%- endcase %}

                    {%- if _range_size != 1 -%}
                      {%- case '@{database_type}' -%}
                        {%- when "bigquery" %} | ' to ' || format_date('@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}', date_add(date_add(${end_date_dim}, interval -{{ _range_end }} DAY), interval -{{ i | minus: 1}} QUARTER))
                        {%- else %} || ' to ' || to_char(date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) , '@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}')
                      {%- endcase %}

                    {%- endif -%} || ')'
                  {%- endif -%}

              {%- when 'prior_year' %}
                  when ${event_date_tz_convert} between
                  {%- case '@{database_type}' -%}
                      {%- when "bigquery" %} date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} YEAR) and date_add(date_add(${end_date_dim}, interval -{{ _range_end }} DAY), interval -{{ i | minus: 1}} YEAR)
                      {%- else %} date_add('yrs', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('yrs', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim}))
                    {%- endcase %}
                     then '{{ _period_prefix | append: " " | append: _period_suffix }}'
                  {%- if display_dates_in_period_labels._parameter_value == 'true' -%}
                    {%- case '@{database_type}' -%}
                      {%- when "bigquery" %} || ' (' || format_date('@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}', date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} YEAR))
                      {%- else %} || ' (' || to_char(date_add('yrs', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})), '@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}')
                    {%- endcase %}

                    {%- if _range_size != 1 -%}
                      {%- case '@{database_type}' -%}
                        {%- when "bigquery" %} || ' to ' || format_date( '@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}',date_add(date_add(${end_date_dim}, interval -{{ _range_end }} DAY), interval -{{ i | minus: 1}} YEAR))
                        {%- else %} || ' to ' || to_char(date_add('yrs', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) , '@{date_display_format}{%- if show_time_in_date_display._parameter_value == 'true' %} @{time_display_format}{%- endif -%}')
                      {%- endcase %}

                    {%- endif -%}
                    || ')'
                  {%- endif -%}

            {%- endcase %}
          {%- endif -%}
          {%- if _compare_to_period == 'prior_period' -%}
            {%- assign _i_plus_one = i | plus: 1 -%}
            {%- assign _range_end = _range_start | plus: 1  -%}
            {%- assign _range_start = _range_size | times: _i_plus_one | plus: _additional_days | floor -%}
          {%- endif -%}
        {% endfor %}
        end
      end


      ;;
  }



  dimension: order_for_period {
    ###
    # Sets the order for period.
    #
    # This dimension is used to establish the proper sort order in the "period" dimension. A numeric sort is needed as the "period" dimension
    # displays human readable form such as "Last Month" or "Prior Period".
    hidden: yes
    type: number
    sql:
        {%- assign _period_selection = period_selection._parameter_value -%}
        {%- assign _compare_to_period = compare_to_period._parameter_value -%}
        {%- assign _range_size = size_of_range._parameter_value | times: 1 -%}
        {%- assign _range_start = _range_size | times: 1 -%}
        {%- assign _range_end = 0 -%}
        {%- assign _additional_days = 0 -%}

        {%- if period_selection._parameter_value == "wtd" or period_selection._parameter_value == "mtd" or period_selection._parameter_value == "qtd"
            or period_selection._parameter_value == "ytd" or period_selection._parameter_value == "lw" or period_selection._parameter_value == "lm"
            or period_selection._parameter_value == "lq" or period_selection._parameter_value == "ly" -%}
            {%- assign _range_size = 0 -%}
            {%- assign _range_start = 0 -%}
            {%- assign _range_end = 0 -%}
            {%- assign _additional_days = 0 %}
        {%- endif -%}
          {%- assign _period_count = period_count._parameter_value | times: 1 -%}
          case
          {% for i in (1.._period_count) %}
            {%- if i == 1 %}
                    when ${event_date_tz_convert} between
                      {%- case '@{database_type}' -%}
                        {%- when "bigquery" %} date_add(${start_date_dim}, interval -{{ _range_start }} DAY) and date_add(${end_date_dim}, interval -{{ _range_end }} DAY)
                        {%- else %} date_add('days', -{{- _range_start -}}, ${start_date_dim}) and date_add('days', -{{- _range_end -}}, ${end_date_dim})
                      {%- endcase %}
                      then {{i}}
            {%- endif -%}
            {%- if i != 1 %}
              {%- case _compare_to_period %}

                {%- when 'prior_period' %}
                    when ${event_date_tz_convert} between
                    {%- case '@{database_type}' -%}
                      {%- when "bigquery" %} date_add(${start_date_dim}, interval -{{ _range_start }} DAY) and date_add(${end_date_dim}, interval -{{ _range_end | minus: 1 }} DAY)
                      {%- else %} date_add('days', -{{- _range_start -}}, ${start_date_dim}) and date_add('days', -{{- _range_end | minus: 1 -}}, ${end_date_dim})
                    {%- endcase %}
                     then {{i}}
                {%- when 'prior_week' %}
                    when ${event_date_tz_convert} between
                      {%- case '@{database_type}' -%}
                        {%- when "bigquery" %} date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} WEEK) and date_add(date_add(${end_date_dim}, interval -{{ _range_end }} DAY), interval -{{ i | minus: 1}} WEEK)
                        {%- else %} date_add('w', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('w', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim}))
                      {%- endcase %}
                      then {{i}}

                {%- when 'prior_month' %}
                  when ${event_date_tz_convert} between
                  {%- case '@{database_type}' -%}
                    {%- when "bigquery" %} date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} MONTH) and date_add(date_add(${end_date_dim},interval -{{ _range_end }} DAY), interval -{{ i | minus: 1}} MONTH)
                    {%- else %} date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim}))
                  {%- endcase %}
                  then {{i}}

                {%- when 'prior_quarter' %}
                  {%- case '@{database_type}' -%}
                    {%- when "bigquery" %} when ${event_date_tz_convert} between date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} QUARTER)  and date_add(date_add(${end_date_dim},interval -{{ _range_end }} DAY), interval -{{ i | minus: 1}} QUARTER)
                    {%- else %} when ${event_date_tz_convert} between date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim}))  and date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim}))
                  {%- endcase %}
                  then {{i}}

                {%- when 'prior_year' %}
                  {%- case '@{database_type}' -%}
                    {%- when "bigquery" %} when ${event_date_tz_convert} between date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} YEAR) and date_add(date_add(${end_date_dim}, interval -{{ _range_end }} DAY), interval  -{{ i | minus: 1}} YEAR)
                    {%- else %} when ${event_date_tz_convert} between date_add('yrs', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('yrs', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim}))
                  {%- endcase %}
                  then {{i}}

              {%- endcase %}
            {%- endif -%}
            {%- if _compare_to_period == 'prior_period' -%}
              {%- assign _i_plus_one = i | plus: 1 -%}
              {%- assign _range_end = _range_start | plus: 1  -%}
              {%- assign _range_start = _range_size | times: _i_plus_one | plus: _additional_days | floor -%}
            {%- endif -%}
        {% endfor %}
        end
        ;;
  }

  dimension: first_period_start_date {
    type: string
    hidden: yes
    sql:
        {%- assign _range_size = size_of_range._parameter_value | times: 1 -%}
        {%- assign _range_start = _range_size | times: 1 -%}

        {%- if period_selection._parameter_value == "wtd" or period_selection._parameter_value == "mtd" or period_selection._parameter_value == "qtd"
            or period_selection._parameter_value == "ytd" or period_selection._parameter_value == "lw" or period_selection._parameter_value == "lm"
            or period_selection._parameter_value == "lq" or period_selection._parameter_value == "ly" -%}
            {%- assign _range_start = 0 -%}
        {%- endif %}

        {%- if _range_start > 0 -%}
          {%- case '@{database_type}' -%}
            {%- when "bigquery" %} date_add(${start_date_dim}, interval -{{ _range_start }}  DAY)
            {%- else %} date_add('days', -{{- _range_start -}}, ${start_date_dim})
          {%- endcase %}
        {%- else -%}
          ${start_date_dim}
        {%- endif -%};;
  }

  dimension: seconds_in_period {
    label: "Seconds in Period"
    view_label: "@{period_control_group_title}"
    group_label: "Period Duration"
    description: "Provides the number of seconds in a period. Useful for table calculations where you might need to find the average of something by dividing by the period size."
    type: number
    sql:
          {%- assign _compare_to_period = compare_to_period._parameter_value -%}
          {%- assign _range_size = size_of_range._parameter_value | times: 1 -%}
          {%- assign _range_start = _range_size | times: 1 -%}
          {%- assign _range_end = 0 -%}
          {%- assign _period_selection = period_selection._parameter_value -%}
          {%- assign _period_count = period_count._parameter_value | times: 1 -%}
          {%- assign _additional_days = 0 -%}
          {%- if period_selection._parameter_value == "wtd" or period_selection._parameter_value == "mtd" or period_selection._parameter_value == "qtd"
              or period_selection._parameter_value == "ytd" or period_selection._parameter_value == "lw" or period_selection._parameter_value == "lm"
              or period_selection._parameter_value == "lq" or period_selection._parameter_value == "ly" -%}
              {%- assign _range_size = 0 -%}
              {%- assign _range_start = 0 -%}
              {%- assign _range_end = 0 -%}
              {%- assign _additional_days = 0 %}
          {% endif %}
          case
          {% for i in (1.._period_count) %}
            {%- if i == 1 -%}
              when ${event_date_tz_convert} between
                {%- case '@{database_type}' -%}
                  {%- when "bigquery" %} date_add(${start_date_dim}, interval -{{ _range_start }} DAY) and date_add(${end_date_dim}, interval -{{ _range_end }} DAY) then date_diff(date_add(${start_date_dim}, interval -{{ _range_start }} DAY),  date_add(${end_date_dim}, interval -{{ _range_end }} DAY), SECOND)
                  {%- else %} date_add('days', -{{- _range_start -}}, ${start_date_dim}) and date_add('days', -{{- _range_end -}}, ${end_date_dim}) then date_diff('seconds',  date_add('days', -{{- _range_start -}}, ${start_date_dim}),  date_add('days', -{{- _range_end -}}, ${end_date_dim}))
                {%- endcase %}

            {%- endif -%}
            {%- if i != 1 %}
              {%- case _compare_to_period %}
                {%- when 'prior_period' %}
                  {%- case '@{database_type}' -%}
                    {%- when "bigquery" %} when ${event_date_tz_convert} between date_add(${start_date_dim}, interval -{{ _range_start }} DAY) and date_add(${end_date_dim}, interval -{{ _range_end | minus: 1 }} DAY) then date_diff(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), date_add(${end_date_dim}, interval -{{ _range_end | minus: 1 }} DAY), SECOND)
                    {%- else %} when ${event_date_tz_convert} between date_add('days', -{{- _range_start -}}, ${start_date_dim}) and date_add('days', -{{- _range_end | minus: 1 -}}, ${end_date_dim}) then date_diff('seconds', date_add('days', -{{- _range_start -}}, ${start_date_dim}), date_add('days', -{{- _range_end | minus: 1 -}}, ${end_date_dim}))
                  {%- endcase %}

                {%- when 'prior_week' %}
                  {%- case '@{database_type}' -%}
                    {%- when "bigquery" %} when ${event_date_tz_convert} between date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} WEEK) and date_add(date_add(${end_date_dim}, interval -{{ _range_end }} DAY), interval -{{ i | minus: 1}} WEEK) then date_diff(date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} WEEK), date_add(date_add(${end_date_dim}, interval -{{ _range_end }} DAY), interval -{{ i | minus: 1}} WEEK), SECOND)
                    {%- else %} when ${event_date_tz_convert} between date_add('w',   -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('w', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then date_diff('seconds', date_add('w',   -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})), date_add('w', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})))
                  {%- endcase %}

                {%- when 'prior_month' %}
                  {%- case '@{database_type}' -%}
                    {%- when "bigquery" %} when ${event_date_tz_convert} between date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} MONTH) and date_add(date_add(${end_date_dim}, interval -{{ _range_end }} DAY), interval -{{ i | minus: 1}} MONTH) then date_diff(date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} MONTH), date_add(date_add(${end_date_dim}, interval -{{ _range_end }} DAY), interval -{{ i | minus: 1}} MONTH), SECOND)
                    {%- else %} when ${event_date_tz_convert} between date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then date_diff('seconds',date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})), date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})))
                  {%- endcase %}

                {%- when 'prior_quarter' %}
                  {%- case '@{database_type}' -%}
                    {%- when "bigquery" %} when ${event_date_tz_convert} between date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} QUARTER) and  date_add(date_add(${end_date_dim}, interval -{{ _range_end }} DAY), interval -{{ i | minus: 1}} QUARTER) then date_diff(date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} QUARTER),  date_add(date_add(${end_date_dim}, interval -{{ _range_end }} DAY), interval -{{ i | minus: 1}} QUARTER), SECOND)
                    {%- else %} when ${event_date_tz_convert} between date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and  date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then date_diff('seconds', date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})),  date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})))
                  {%- endcase %}

                {%- when 'prior_year' %}
                  {%- case '@{database_type}' -%}
                    {%- when "bigquery" %} when ${event_date_tz_convert} between date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} YEAR) and date_add(date_add(${end_date_dim}, interval -{{ _range_end }} DAY), interval -{{ i | minus: 1}} YEAR) then date_diff(date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} YEAR) and date_add(date_add(${end_date_dim}, interval -{{ _range_end }} DAY), interval -{{ i | minus: 1}} YEAR), SECOND)
                    {%- else %} when ${event_date_tz_convert} between date_add('yrs', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('yrs', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then date_diff('seconds', date_add('yrs', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('yrs', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})))
                  {%- endcase %}

              {%- endcase %}
            {%- endif -%}
            {%- if _compare_to_period == 'prior_period' -%}
                {%- assign _i_plus_one = i | plus: 1 -%}
                {%- assign _range_end = _range_start | plus: 1  -%}
                {%- assign _range_start = _range_size | times: _i_plus_one | plus: _additional_days | floor -%}
            {%- endif -%}
          {% endfor %}
          end;;
  }

  dimension_group: date_in_period {
    ##
    # Date group used on X axis for time series analysis type charts.
    label: "Date in Period"
    view_label: "@{period_control_group_title}"
    group_label: "X Axis Dimensions"
    description: "Use this as your date dimension when comparing periods. Aligns the all previous periods onto the current period"
    type: time
    convert_tz: no
    # timeframes: [date, quarter, year, month, week, day_of_week,fiscal_month_num, fiscal_quarter, quarter_of_year]
    sql:

      {%- if period_count._parameter_value != 1 %}
        {%- case '@{database_type}' -%}
          {%- when "bigquery" %} date_add(${first_period_start_date}, interval ${seconds_in_period} SECOND)
          {%- else %} date_add('seconds', ${seconds_in_period}, ${first_period_start_date})
        {%- endcase %}

      {%- else -%}
        ${event_date_tz_convert}
      {%- endif %};;
  }

  dimension: minutes_in_period {
    label: "Minutes in Period"
    view_label: "@{period_control_group_title}"
    group_label: "Period Duration"
    description: "Provides the number of minutes in a period. Useful for table calculations where you might need to find the average of something by dividing by the period size."
    type: number
    sql:${seconds_in_period}/60;;
  }

  dimension: days_in_period {
    alias: [period_1_len]
    label: "Days in Period"
    view_label: "@{period_control_group_title}"
    group_label: "Period Duration"
    description: "Provides the number of days in a period. Useful for table calculations where you might need to find the average of something by dividing by the period size. For example, revenue per day."
    type: number
    sql: round(${seconds_in_period}::decimal/86400, 4);;
  }

  # measure: min_start_date {
  #   label: "Start Date"
  #   type: min
  #   sql: ${start_date} ;;
  # }

  parameter: show_time_in_date_display {
    type: yesno
    default_value: "no"
    description: "Display the time in the first period date range display"
    view_label: "@{period_control_group_title}"
    group_label: "Display Blocks"
  }

  measure: min_date_in_range {
    type: min
    sql: ${date_in_period_date} ;;
  }

  measure: max_date_in_range {
    type: max
    sql: ${date_in_period_date} ;;
  }

  measure: date_range_display_period_1 {
    label: "First Period Date Range"
    description: "This will display the date range for the first period."
    view_label: "@{period_control_group_title}"
    group_label: "Display Blocks"
    type: string
    sql:
    case when  ${invalid_state_warning} <> '' then ${invalid_state_warning}
    else
    {%- if show_time_in_date_display._parameter_value == 'false' %}

      {%- case '@{database_type}' -%}
        {%- when "bigquery" %} format_date('@{date_display_format}', ${min_date_in_range}) || ' to ' || format_date('@{date_display_format}', ${max_date_in_range})
        {%- else %} to_char(${min_date_in_range}, '@{date_display_format}') || ' to ' || to_char(${max_date_in_range}, '@{date_display_format}')
      {%- endcase %}

    {%- else %}

      {%- case '@{database_type}' -%}
        {%- when "bigquery" %} format_date('@{date_display_format} @{time_display_format}', ${min_date_in_range}) || ' to ' || format_date('@{date_display_format} @{time_display_format}', ${max_date_in_range})
        {%- else %} to_char(${min_date_in_range}, '@{date_display_format} @{time_display_format}') || ' to ' || to_char(${max_date_in_range}, '@{date_display_format} @{time_display_format}')
      {%- endcase %}

    {%- endif %}
    end
    ;;
    html:
    {% if rendered_value contains 'ERROR' %}
      <div style='white-space: pre-wrap; background-color: red; color: white; font-size: 2vw; border: 3px solid rgb(117, 15, 8);'>{{rendered_value}}</div>
    {% else %}
      <span style='white-space: pre-wrap;'>{{rendered_value}}</span>
    {% endif %};;
  }

  dimension: sql_always_where_inject {
    hidden: yes
    sql:
        {%- assign _period_selection = period_selection._parameter_value -%}
        {%- if _period_selection != "none" -%}
          {%- assign _compare_to_period = compare_to_period._parameter_value -%}
          {%- assign _range_size = size_of_range._parameter_value | times: 1 -%}
          {%- assign _range_start = _range_size | times: 1 -%}
          {%- assign _range_end = 0 -%}
          {%- assign _period_count = period_count._parameter_value | times: 1 -%}
          {%- assign _additional_days = 0 -%}
          {%- if period_selection._parameter_value == "wtd" or period_selection._parameter_value == "mtd" or period_selection._parameter_value == "qtd"
            or period_selection._parameter_value == "ytd" or period_selection._parameter_value == "lw" or period_selection._parameter_value == "lm"
            or period_selection._parameter_value == "lq" or period_selection._parameter_value == "ly" -%}
              {%- assign _range_size = 0 -%}
              {%- assign _range_start = 0 -%}
              {%- assign _range_end = 0 -%}
              {%- assign _additional_days = 0 %}
          {%- endif -%}
          {% if debug._parameter_value == 'true' %}
            -- *****************************************
            -- As of Value:       {% parameter as_of_date %}
            -- Period Selection:  {{_period_selection}}
            -- Exclude Value:     {% parameter exclude_days %}
            -- Snap Start Date:   {% parameter snap_start_date_to %}
            -- Compare to Period: {% parameter compare_to_period %}
            -- Range Size:        {{_range_size}}
            -- Additional Days:   {{ _additional_days }}
            -- Range Start:       {{ _range_start }}
            -- Range End:         {{ _range_end }}
            -- Convert TZ:        {% parameter convert_tz %}
            -- *****************************************
          {% endif %}
          {%- for i in (1.._period_count) %}
            {%- if i == 1 %}
              {%- if snap_start_date_to._parameter_value != 'none' and compare_to_period._parameter_value == 'none' -%}
                ${event_date_tz_convert} between

                {% case '@{database_type}' -%}
                  {%- when "bigquery" %} date_trunc(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), '{%- parameter snap_start_date_to -%}') and date_add(${end_date_dim}, interval -{{ _range_end }} DAY)
                  {%- else %} date_trunc('{%- parameter snap_start_date_to -%}', date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('days', -{{- _range_end -}}, ${end_date_dim})
                {%- endcase %}

              {%- elsif snap_start_date_to._parameter_value != 'none' and compare_to_period._parameter_value != 'none' -%}
                 1=0 -- Do nothing. Invalid state, you cannot use snap feature with a compare period

              {% else -%}

                {%- case '@{database_type}' -%}
                  {%- when "bigquery" %} ${event_date_tz_convert} between date_add(${start_date_dim}, interval -{{ _range_start }} DAY) and date_add(${end_date_dim}, interval -{{ _range_end }} DAY)
                  {%- else %} ${event_date_tz_convert} between date_add('days', -{{- _range_start -}}, ${start_date_dim}) and date_add('days', -{{- _range_end -}}, ${end_date_dim})
                {%- endcase %}

              {%- endif -%}
            {%- endif -%}
            {%- if i != 1 %}
              {%- case _compare_to_period %}
                {%- when 'prior_period' %}
                  or
                  {%- case '@{database_type}' -%}
                    {%- when "bigquery" %} ${event_date_tz_convert} between date_add(${start_date_dim}, interval -{{ _range_start }} DAY) and date_add(${end_date_dim}, interval -{{ _range_end | minus: 1 }} DAY)
                    {%- else %} ${event_date_tz_convert} between date_add('days', -{{- _range_start -}}, ${start_date_dim}) and date_add('days', -{{- _range_end | minus: 1 -}}, ${end_date_dim})
                  {%- endcase %}


                {%- when 'prior_week' %}
                  or
                  {%- case '@{database_type}' -%}
                    {%- when "bigquery" %} ${event_date_tz_convert} between date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} WEEK) and date_add(date_add(${end_date_dim}, interval -{{ _range_end }} DAY), interval -{{ i | minus: 1}} WEEK)
                    {%- else %} ${event_date_tz_convert} between date_add('w',   -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('w',   -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim}))
                  {%- endcase %}


                {%- when 'prior_month' %}
                    or
                  {%- case '@{database_type}' -%}
                    {%- when "bigquery" %} ${event_date_tz_convert} between date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} MONTH) and date_add(date_add(${end_date_dim}, interval -{{ _range_end }} DAY), interval -{{ i | minus: 1}} MONTH)
                    {%- else %} ${event_date_tz_convert} between date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim}))
                  {%- endcase %}


                {%- when 'prior_quarter' %}
                    or
                  {%- case '@{database_type}' -%}
                    {%- when "bigquery" %} ${event_date_tz_convert} between date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} QUARTER)  and date_add(date_add(${end_date_dim}, interval -{{ _range_end }} DAY), interval -{{ i | minus: 1}} QUARTER)
                    {%- else %} ${event_date_tz_convert} between date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim}))  and date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim}))
                  {%- endcase %}

                {%- when 'prior_year' %}
                    or
                  {%- case '@{database_type}' -%}
                    {%- when "bigquery" %} ${event_date_tz_convert} between date_add(date_add(${start_date_dim}, interval -{{ _range_start }} DAY), interval -{{ i | minus: 1}} YEAR) and date_add(date_add(${end_date_dim}, interval -{{ _range_end }} DAY), interval -{{ i | minus: 1}} YEAR)
                    {%- else %} ${event_date_tz_convert} between date_add('year', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('year', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim}))
                  {%- endcase %}

              {%- endcase %}
            {%- endif -%}
            {%- if _compare_to_period == 'prior_period' -%}
              {%- assign _i_plus_one = i | plus: 1 -%}
              {%- assign _range_end = _range_start | plus: 1  -%}
              {%- assign _range_start = _range_size | times: _i_plus_one | plus: _additional_days | floor -%}
            {%- endif -%}
          {% endfor %}
          -- Required for error warnings
          or ${invalid_state_warning} <> ''
      {%- else -%}
        -- Period Control Block is not enabled for this query.
        1 = 1
      {%- endif -%};;
  }


}
