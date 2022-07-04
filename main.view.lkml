# Backup July 3rd before roll back

# Copyright 2022 Cold Bore Capital Management, LLC
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

###
# TODO List
#  - Set the default number of days for a normalized month or quarter to the most recent month or quarter.
#  - You can make a date display block using your date between function. You can simply tie the date display block to
#    your dates table, then run a min and a max function on the resulting values. This will display the min and max values
#    in the range super easy.



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
    view_label: "@{block_field_name}"
  }

  parameter: size_of_range {
    alias: [user_size_of_range]
    description: "How many days in your period? Only applies to the Trailing option of the Period Selection parameter."
    label: "Number of Trailing Days"
    group_label: "Tile or Dashboard Filters"
    view_label: "@{block_field_name}"
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
    label: "Tile Exclude Days"
    group_label: "Tile or Dashboard Filters"
    view_label: "@{block_field_name}"
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
      label: "Last Data"
      value: "999"
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
    view_label: "@{block_field_name}"
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
      label: "Today"
      value: "today"
    }
    allowed_value: {
      label: "Yesterday"
      value: "yesterday"
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
    view_label: "@{block_field_name}"
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
  }

  parameter: normalize_range_size {
    label: "Normalize Range Sizes"
    description: "When comparing ranges like month over month, or quarter over quarter, differences in the number of days in a month can cause different range sizes. Setting this value to Yes will use 28 days in a month, 91 days in a quarter, and 365 days in a year instead of the actual values"
    view_label: "@{block_field_name}"
    group_label: "Tile or Dashboard Filters"
    type: yesno
    default_value: "yes"
  }

  parameter: debug {
    label: "Debug Mode"
    group_label: "Tile Only Filters"
    view_label: "@{block_field_name}"
    type: yesno
    default_value: "no"
  }

  # ******
  ## Tile Only Filters

  parameter: period_count {
    alias: [comparison_periods, period_size]
    label: "Number of Periods"
    group_label: "Tile Only Filters"
    view_label: "@{block_field_name}"
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
    group_label: "Tile Only Filters"
    view_label: "@{block_field_name}"
    description: "Display the dates alongside the periods. For example 'Current Period - 2021-01-01 to 2021-04-01'. Note that this will cause any custom colors set for the series to break when the dates change (i.e. the next day)."
    type: yesno
    default_value: "No"
  }

  parameter: user_exclude_tile_override_dashboard {
    description: "Setting this to Override will cause the tile level exclude days selection to override any dashboard level selection"
    label: "Override Dashboard Exclude Days"
    view_label: "@{block_field_name}"
    group_label: "Tile Only Filters"
    type: unquoted
    allowed_value: {
      label: "Do Not Override"
      value: "0"
    }
    allowed_value: {
      label: "Override"
      value: "1"
    }
    default_value: "0"
  }

  parameter: snap_start_date_to {
    # The period control block is designed to be used at a dashboard level with tiles that compare period over period, and tiles that just display normal date
    # ranges. The snap function ensures that a chart or table displaying a day, week, month, quarter, or year, is actually displaying the full date range. The
    # effect of this parameter is to add a date_trunc('{snap value}', start_date) type function to the start date, thereby ensuring that the start date is the
    # true expected start of the range.
    alias: [user_snap_start_date_to, tile_snap_start_date_to]
    label: "Snap Start Date to"
    description: "Setting this filter will ensure that the start date includes the begining of the selected period. For example, if you selected trailing 365, the first month might be partial. Selecting snap to month would ensure a complete first month. Cannot be used with period over period."
    view_label: "@{block_field_name}"
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

  dimension: snap_dim {
    # Allows for output of snap to value
    hidden: yes
    type: string
    sql:
    {%- if period_count._parameter_value != '1' -%}
      ; select 'WARNING: SNAP TO CANNOT BE USED WITH PERIOD OVER PERIOD' as warning;
    {%- elsif snap_start_date_to._parameter_value != 'none' -%}
      '{%- parameter snap_start_date_to -%} '
    {%- endif -%}
    ;;
  }

  dimension: event_date_tz_convert {
    # Looker converts any date with time to a string using a TO_CHAR function. This is super annoying, but there seems to be no way around it. @todo to figure out
    # some sort of workaround for this very annoying "feature". date_raw doesn't allow for TZ conversion. For now, we have to re-cast the timezone converted date
    # to timestamp from char.
    hidden: yes
    type: date_raw
    convert_tz: no
    sql:
    {%- if convert_tz._parameter_value == 'true' -%}
       convert_timezone('utc', '{{ _query._query_timezone }}', ${event_date})
    {%- else -%}
        ${event_date}
    {%- endif -%}
    ;;
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
    {%- if _query._query_timezone != 'utc' -%}
        convert_timezone('utc', '{{ _query._query_timezone }}', getdate())
    {%- else -%}
        getdate()
    {%- endif -%};;
    convert_tz: no
  }

  dimension: getdate_final {
    # This dimension performes two key operations:
    # 1. If an as of date is selected, it subs that instead of the real date.
    # 2. It converts the date to one second before midnight. For example, if getdate() returns 2022-01-01 05:03:00, it will first be converted to 2022-01-01 00:00:00, then
    #    converted to 2022-01-01 23:59:59 so that the full day is included in the range.
    hidden: yes
    type: date_raw
    sql:
      {%- if as_of_date._parameter_value == 'NULL' -%}
         date_add('seconds', 86399, date(${getdate_func}))
      {%- else -%}
        date_add('seconds', 86399, {%- parameter as_of_date -%})
      {%- endif -%};;
    convert_tz: no
  }

  dimension: end_date_dim_pre_as_of_mod {
    ##
    # This will return the date to be used as the end date for Period 1 with "exclude days" filters or "as date" options applied
    type: date_raw
    convert_tz: no
    hidden:  yes
    sql:{%- if as_of_date._parameter_value == 'NULL' and exclude_days._parameter_value != '0' -%}
          {%- case exclude_days._parameter_value -%}
           {%- when "999" -%}
              -- Find max date in the available data and set to today. `origin_event_date` and `origin_table_name` are both set in the view.
              (select max(${origin_event_date}) from ${origin_table_name})
           {%- when "1" -%}
              dateadd('days', -1, ${getdate_final})
           {%- when "2" -%}
              dateadd('days', -2, ${getdate_final})
           {%- when "last_full_week" -%}
              dateadd('days', -1, date_trunc('week', ${getdate_final}))
           {%- when "last_full_month" -%}
              dateadd('days', -1, date_trunc('month', ${getdate_final}))
           {%- when "last_full_quarter" -%}
              dateadd('days', -1, date_trunc('quarter', ${getdate_final}))
           {%- when "last_full_year" -%}
              dateadd('days', -1, date_trunc('year', ${getdate_final}))
           {%- else -%}
              ${getdate_final}
          {%- endcase -%}
        {%- else -%}
          ${getdate_final}
        {%- endif -%}
        ;;
  }

  dimension: end_date_dim {
    # Final state of the end date dimension
    # Note: When as_of_date is selected, a day is added to account for the value being inclusive of the selected day. In a later
    #       operation, a second will be subtracted. This will cause the date range to be one milisecond before midnight. If an as_of_date
    #       value of '2022-06-23' is selected, the net effect will be a final date range ending at 2022-06-23 23:59:59.999000
    #
    hidden: yes
    type: date_raw
    convert_tz: no
    sql:
        {%- if as_of_date._parameter_value == 'NULL' -%}
          ${getdate_final}
        {%- else -%}
          date_add('seconds', 86399, date(${getdate_final}))
        {%- endif -%}
    ;;
  }

  dimension: start_date_pre {
    hidden: yes
    sql:
      {%- if snap_start_date_to._parameter_value != 'none' -%}
          date_trunc(${snap_dim},
      {%- endif -%}

      {%- if as_of_date._parameter_value == 'NULL' -%}
          date_add('seconds', 86399, date(${getdate_func}))
      {%- else -%}
          date_add('seconds', 86399, {%- parameter as_of_date -%})
      {%- endif -%}

      {%- if snap_start_date_to._parameter_value != 'none' -%}
          )
      {%- endif -%};;
  }

  dimension: start_date_dim {
    ##
    # This dimension handles any date truncation needed for WTD, MTD, YTD type operations.
    #
    # The start_date_dim will be used as the starting date for start period date calcs. When a {x}td type seletion is made, the period size will
    # be set to zero, relying on the date trunc operation to set the start date of the period.
    #
    # Notes:
    #   1. The else case handles all trailing, today, and yesterday selections.
    hidden: yes
    type: date_raw
    convert_tz: no
    sql:

        {%- case period_selection._parameter_value -%}
            {%- when 'wtd' -%}
                date_trunc('w', ${start_date_pre})
            {%- when 'mtd' -%}
                date_trunc('mon', ${start_date_pre})
            {%- when 'qtd' -%}
                date_trunc('qtrs', ${start_date_pre})
            {%- when 'ytd' -%}
                date_trunc('y', ${start_date_pre})
            {%- else -%}
                ${start_date_pre}
         {%- endcase -%}

        ;;
  }




  # *************************
  # Size of Range and Period
  # *************************

  dimension: period_name_selection {
    hidden: yes
    sql: {%- case period_selection._parameter_value -%}
              {%- when "trailing" -%} 'Period'
              {%- when 'today' or "yesterday" -%} 'Day'
              {%- when "wtd" or "lw" -%} 'Week'
              {%- when "mtd" or "lm" -%} 'Month'
              {%- when "qtd" or "lq" -%} 'Quarter'
              {%- when "ytd" or "ly" -%} 'Year'
           {%- endcase -%};;
  }

  # *************************************************************************************
  # Period Block
  # *************************************************************************************

  dimension: period {
    view_label: "@{block_field_name}"
    label: "Period Pivot Dev"
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
        {%- assign _compare_to_period = compare_to_period._parameter_value -%}
        {%- assign _range_size = size_of_range._parameter_value | times: 1 -%}
        {%- assign _range_start = _range_size | times: 1 -%}
        {%- assign _range_end = 0 -%}
        {%- assign _period_selection = period_selection._parameter_value -%}
        {%- assign _period_count_values = "1st,2nd,3rd,4th,5th,6th,7th,8th,9th,10th,11th,12th,13th,14th,15th,16th,17th,18th,19th,20th,21st,22nd,23rd,24th,25th,26th,27th,28th,29th,30th,31st,32nd,33rd,34th,35th,36th,37th,38th,39th,40th,41st,42nd,43rd,44th,45th,46th,47th,48th,49th,50th,51st,52nd,53rd" | split: ',' %}
        {%- assign _additional_days = 0 -%}
        {%- if period_selection._parameter_value == "today" -%}
            {%- assign _range_size = 1 -%}
            {%- assign _range_start = _range_size -%}
            {%- assign _range_end = 0 -%}
        {%- elsif period_selection._parameter_value == "yesterday" -%}
            {%- assign _range_size = 1 -%}
            {%- assign _range_start = 2 -%}
            {%- assign _range_end = 1 -%}
            {%- assign _additional_days = 1 %}
        {%- elsif period_selection._parameter_value == "wtd" or period_selection._parameter_value == "mtd" or period_selection._parameter_value == "qtd" or period_selection._parameter_value == "ytd" -%}
            {%- assign _range_size = 0 -%}
            {%- assign _range_start = 0 -%}
            {%- assign _range_end = 0 -%}
            {%- assign _additional_days = 0 %}
        {%- endif -%}
         {%- comment -%}Check for invalid states{%- endcomment -%}
        {%- if (_compare_to_period == 'prior_week' and _range_size > 7 and _period_selection == 'trailing') %}
            'WARNING: Cannot compare prior week over 7 days. {{_range_size}} days selected.'
        {%- elsif (_compare_to_period == 'prior_month' and _range_size > 28 and _period_selection == 'trailing') %}
            'WARNING: Cannot compare prior month over 28 days. {{_range_size}} days selected.'
        {%- elsif (_compare_to_period == 'prior_quarter' and _range_size > 91 and _period_selection == 'trailing') %}
            'WARNING: Cannot compare prior quarter over 91 days. {{_range_size}} days selected.'
        {%- elsif (_compare_to_period == 'prior_year' and _range_size > 365 and _period_selection == 'trailing') %}
            'WARNING: Cannot compare prior year over 365 days. {{_range_size}} days selected.'
        {%- elsif (_period_selection == 'wtd' or _period_selection == 'mtd' or _period_selection == 'qtd' or _period_selection == 'ytd'
           or _period_selection == 'lw' or _period_selection == 'lm'  or _period_selection == 'lq' or _period_selection == 'ly')
           and _compare_to_period == 'prior_period' %}
            'ERROR: Cannot use {{_period_selection}} with a Prior Period compare to selection'
        {%- elsif _period_selection == 'mtd' and _compare_to_period == 'prior_week' %}
            'ERROR: Cannot use Month to Date with a Prior Week compare to selection'
        {%- elsif _period_selection == 'qtd' and (_compare_to_period == 'prior_week' or _compare_to_period == 'prior_month') %}
            'ERROR: Cannot use Quarter to Date with a Prior Week or Prior Month compare to selection'
        {%- elsif _period_selection == 'ytd' and (_compare_to_period == 'prior_week' or _compare_to_period == 'prior_month' or _compare_to_period == 'prior_quarter') %}
            'ERROR: Cannot use Year to Date can only be used with a Prior Year compare to selection'
        {%- else -%}
          {%- assign _period_count = period_count._parameter_value | times: 1 -%}
          {% if debug._parameter_value == 'true' %}

              -- *****************************************
              -- Period Selection: {{_period_selection}}
              -- Compare To:       {{_compare_to_period}}
              -- Range Size:       {{_range_size}}
              -- Additional Days:  {{ _additional_days }}
              -- *****************************************
          {% endif %}
          case
          {% for i in (1.._period_count) -%}
            {% if debug._parameter_value == 'true' %}
              -- *****************************************
              -- Range Start:      {{ _range_start }}
              -- Range End:        {{ _range_end }}
              -- *****************************************
            {%- endif %}
            {%- assign _zero_index = i | minus: 1 -%}
            {%- assign _period_prefix = _period_count_values[_zero_index] -%}
            {%- assign _period_suffix = 'Period' -%}
            {%- assign _period_name = "'" | append: _period_prefix | append: " " | append: _period_suffix | append: "'" -%}

            {%- if i == 1 %}
                    when ${event_date_tz_convert} between date_add('days', -{{- _range_start -}}, ${start_date_dim}) and date_add('days', -{{- _range_end -}}, ${end_date_dim}) then {{ _period_name }}
                 {%- if display_dates_in_period_labels._parameter_value == 'true' -%}
                    || ' (' || to_char(date_add('days', -{{- _range_start -}}, ${start_date_dim}), '@{date_display_format}') || ' to ' || to_char(date_add('days', -{{- _range_end -}}, ${end_date_dim}), '@{date_display_format}') || ')'
                 {%- endif -%}
            {%- endif -%}

            {%- if i != 1 %}
              {%- case compare_to_period._parameter_value %}
                {%- when 'prior_period' %}
                    when ${event_date_tz_convert} between date_add('days', -{{- _range_start -}}, ${start_date_dim}) and date_add('days', -{{- _range_end | minus: 1 -}}, ${end_date_dim}) then {{ _period_name }}
                  {%- if display_dates_in_period_labels._parameter_value == 'true' -%}
                      || ' (' || to_char(date_add('days', -{{- _range_start -}}, ${start_date_dim}), '@{date_display_format}') || ' to ' || to_char(date_add('days', -{{- _range_end | minus: 1 -}}, ${end_date_dim}), '@{date_display_format}') || ')'
                  {%- endif -%}

                {%- when 'prior_week' %}
                    when ${event_date_tz_convert} between date_add('w',   -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('w',   -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then {{ _period_name }}
                  {%- if display_dates_in_period_labels._parameter_value == 'true' -%}
                      || ' (' || to_char(date_add('w',   -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})), '@{date_display_format}') || ' to ' || to_char(date_add('w',   -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})), '@{date_display_format}') || ')'
                  {%- endif -%}

                {%- when 'prior_month' %}
                  {%- if _normalize_range_size == 'true' %}
                    when ${event_date_tz_convert} between date_add('days', -{{- i | minus: 1 | times: 28}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('days', -{{- i | minus: 1 | times: 28}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then '{{ _period_prefix | append: " " | append: _period_suffix }}'
                    {%- if display_dates_in_period_labels._parameter_value == 'true' -%}
                      || ' (' || to_char(date_add('days', -{{- i | minus: 1 | times: 28}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})), '@{date_display_format}') || ' to ' || to_char(date_add('days', -{{- i | minus: 1 | times: 28}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})), '@{date_display_format}') || ')'
                    {%- endif -%}

                  {%- elsif _normalize_range_size != 'true' %}
                    when ${event_date_tz_convert} between date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then '{{ _period_prefix | append: " " | append: _period_suffix }}'
                    {%- if display_dates_in_period_labels._parameter_value == 'true' -%}
                      || ' (' || to_char(date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) , '@{date_display_format}') || ' to ' || to_char(date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) , '@{date_display_format}') || ')'
                    {%- endif -%}

                  {%- endif -%}

                {%- when 'prior_quarter' %}
                  {%- if normalize_range_size._parameter_value == 'true' -%}
                    when ${event_date_tz_convert} between date_add('days', -{{- i | minus: 1 | times: 91}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('days', -{{- i | minus: 1 | times: 91}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then '{{ _period_prefix | append: " " | append: _period_suffix }}'
                    {%- if display_dates_in_period_labels._parameter_value == 'true' -%}
                      || ' (' || to_char(date_add('days', -{{- i | minus: 1 | times: 91}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) , '@{date_display_format}') || ' to ' || to_char(date_add('days', -{{- i | minus: 1 | times: 91}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) , '@{date_display_format}') || ')'
                    {%- endif -%}

                  {%- elsif _normalize_range_size != 'true' %}
                    when ${event_date_tz_convert} between date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim}))  and date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then '{{ _period_prefix | append: " " | append: _period_suffix }}'
                    {%- if display_dates_in_period_labels._parameter_value == 'true' -%}
                      || ' (' || to_char(date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) , '@{date_display_format}') || ' to ' || to_char(date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) , '@{date_display_format}') || ')'
                    {%- endif -%}
                  {%- endif -%}

                {%- when 'prior_year' %}
                  {%- if normalize_range_size._parameter_value == 'true' -%}
                    when ${event_date_tz_convert} between date_add('days', -{{- i | minus: 1 | times: 365}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('days', -{{- i | minus: 1 | times: 365}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then '{{ _period_prefix | append: " " | append: _period_suffix }}'
                    {%- if display_dates_in_period_labels._parameter_value == 'true' -%}
                      || ' (' || to_char(date_add('days', -{{- i | minus: 1 | times: 365}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) , '@{date_display_format}') || ' to ' || to_char(date_add('days', -{{- i | minus: 1 | times: 365}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) , '@{date_display_format}') || ')'
                    {%- endif -%}

                  {%- elsif _normalize_range_size != 'true' %}
                    when ${event_date_tz_convert} between date_add('yrs', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('yrs', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then '{{ _period_prefix | append: " " | append: _period_suffix }}'
                    {%- if display_dates_in_period_labels._parameter_value == 'true' -%}
                      || ' (' || to_char(date_add('yrs', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})), '@{date_display_format}') || ' to ' || to_char(date_add('yrs', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) , '@{date_display_format}') || ')'
                    {%- endif -%}

                  {%- endif -%}

              {%- endcase -%}
            {%- endif -%}
            {%- if compare_to_period._parameter_value == 'prior_period' -%}
              {%- assign _i_plus_one = i | plus: 1 -%}
              {%- assign _range_end = _range_start | plus: 1  -%}
              {%- assign _range_start = _range_size | times: _i_plus_one | plus: _additional_days | floor -%}
            {%- endif -%}
          {% endfor %}
          end
      {%- endif -%}
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
        {%- assign _compare_to_period = compare_to_period._parameter_value -%}
        {%- assign _range_size = size_of_range._parameter_value | times: 1 -%}
        {%- assign _range_start = _range_size | times: 1 -%}
        {%- assign _range_end = 0 -%}
        {%- assign _additional_days = 0 -%}

        {%- if period_selection._parameter_value == "today" -%}
            {%- assign _range_size = 1 -%}
            {%- assign _range_start = _range_size -%}
            {%- assign _range_end = 0 -%}
        {%- elsif period_selection._parameter_value == "yesterday" -%}
            {%- assign _range_size = 1 -%}
            {%- assign _range_start = 2 -%}
            {%- assign _range_end = 1 -%}
            {%- assign _additional_days = 1 %}
        {%- elsif period_selection._parameter_value == "wtd" or period_selection._parameter_value == "mtd" or period_selection._parameter_value == "qtd" or period_selection._parameter_value == "ytd" -%}
            {%- assign _range_size = 0 -%}
            {%- assign _range_start = 0 -%}
            {%- assign _range_end = 0 -%}
            {%- assign _additional_days = 0 %}
        {%- endif -%}
          {%- assign _period_count = period_count._parameter_value | times: 1 -%}
          {% if debug._parameter_value == 'true' %}
              -- *****************************************
              -- Compare To:       {{_compare_to_period}}
              -- Range Size:       {{_range_size}}
              -- Additional Days:  {{ _additional_days }}
              -- *****************************************
          {%- endif %}
          case
          {% for i in (1.._period_count) %}
            {% if debug._parameter_value == 'true' %}
              -- *****************************************
              -- Range Start:      {{ _range_start }}
              -- Range End:        {{ _range_end }}
              -- *****************************************
            {%- endif %}
            {%- if i == 1 %}
                    when ${event_date_tz_convert} between date_add('days', -{{- _range_start -}}, ${start_date_dim}) and date_add('days', -{{- _range_end -}}, ${end_date_dim}) then {{i}}
            {%- endif -%}
            {%- if i != 1 %}
              {%- case _compare_to_period %}

                {%- when 'prior_period' %}
                    when ${event_date_tz_convert} between date_add('days', -{{- _range_start -}}, ${start_date_dim}) and date_add('days', -{{- _range_end | minus: 1 -}}, ${end_date_dim}) then {{i}}

                {%- when 'prior_week' %}
                    when ${event_date_tz_convert} between date_add('w',   -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('w',   -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then {{i}}

                {%- when 'prior_month' %}
                  {%- if _normalize_range_size == 'true' %}
                    when ${event_date_tz_convert} between date_add('days', -{{- i | minus: 1 | times: 28 }}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('days', -{{- i | minus: 1 | times: 28}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then {{i}}

                  {%- elsif _normalize_range_size != 'true' %}
                    when ${event_date_tz_convert} between date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then {{i}}
                  {%- endif -%}

                {%- when 'prior_quarter' %}
                  {%- if normalize_range_size._parameter_value == 'true' -%}
                    when ${event_date_tz_convert} between date_add('days', -{{- i | minus: 1 | times: 91 }}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('days', -{{- i | minus: 1 | times: 91}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then {{i}}

                  {%- elsif _normalize_range_size != 'true' %}
                    when ${event_date_tz_convert} between date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim}))  and date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then {{i}}
                  {%- endif -%}

                {%- when 'prior_year' %}
                  {%- if normalize_range_size._parameter_value == 'true' -%}
                    when ${event_date_tz_convert} between date_add('days', -{{- i | minus: 1 | times: 365}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('days', -{{- i | minus: 1 | times: 365}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then {{i}}

                  {%- elsif _normalize_range_size != 'true' %}
                    when ${event_date_tz_convert} between date_add('yrs', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('yrs', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then {{i}}
                  {%- endif -%}

              {%- endcase -%}
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
        {%- if period_selection._parameter_value == "today" -%}
            {%- assign _range_start = _range_size -%}
        {%- elsif period_selection._parameter_value == "yesterday" -%}
            {%- assign _range_start = 2 -%}
        {%- elsif period_selection._parameter_value == "wtd" or period_selection._parameter_value == "mtd" or period_selection._parameter_value == "qtd" or period_selection._parameter_value == "ytd" -%}
            {%- assign _range_start = 0 -%}
        {%- endif %}

        {%- if _range_start > 0 -%}
          date_add('days', -{{- _range_start -}}, ${start_date_dim})
        {%- else -%}
          ${start_date_dim}
        {%- endif -%};;
  }

  # Note. The problem is, you are subtracting the number of days from the period. This is a real issue, because if you want to work in hours, you
  # need to get the diff in number of hours instead. Otherwise you are never going to go below the day level. You need a way to select hours, and I can't think of
  # anything easy.

  dimension_group: date_in_period {
    ##
    # Date group used on X axis for time series analysis type charts.
    label: "Date in Period"
    view_label: "@{block_field_name}"
    group_label: "X Axis Dimensions"
    description: "Use this as your date dimension when comparing periods. Aligns the all previous periods onto the current period"
    type: time
    # timeframes: [date, quarter, year, month, week, day_of_week,fiscal_month_num, fiscal_quarter, quarter_of_year]
    sql:
      {%- if period_count._parameter_value != 1 -%}
        dateadd('seconds', ${day_in_period}, ${first_period_start_date})
      {%- else -%}
        ${event_date_tz_convert}
      {%- endif -%};;
    convert_tz: no
  }

  dimension: day_in_period {
    ##
    # Returns a number relative  to the start of the period.
    #
    # Used by the dimension_group "date_in_period" to calculate the date for any given grouping, this dimension can also be used
    # to display the X-Axis in a relative 1, 2, 3 output instead of dates.
    label: "Day in Period"
    view_label: "@{block_field_name}"
    group_label: "X Axis Dimensions"
    description: "Gives the number of days since the start of each periods. Use this to align the event dates onto the same axis, the axes will read 1,2,3, etc."
    type: number
    sql:
          {%- assign _compare_to_period = compare_to_period._parameter_value -%}
          {%- assign _range_size = size_of_range._parameter_value | times: 1 -%}
          {%- assign _range_start = _range_size | times: 1 -%}
          {%- assign _range_end = 0 -%}
          {%- assign _period_selection = period_selection._parameter_value -%}
          {%- assign _normalize_range_size = normalize_range_size._parameter_value -%}
          {%- assign _period_count = period_count._parameter_value | times: 1 -%}
          {%- assign _additional_days = 0 -%}
          {%- if _period_selection == "today" -%}
              {%- assign _range_size = 1 -%}
              {%- assign _range_start = _range_size -%}
              {%- assign _range_end = 0 -%}
              {%- assign _end_period_value = 0 -%}
          {%- elsif _period_selection == "yesterday" -%}
              {%- assign _range_size = 1 -%}
              {%- assign _range_start = 2 -%}
              {%- assign _range_end = 1 -%}
              {%- assign _additional_days = 1 %}
          {%- elsif _period_selection == "wtd" or _period_selection == "mtd" or _period_selection == "qtd" or _period_selection == "ytd" -%}
              {%- assign _range_size = 0 -%}
              {%- assign _range_start = 0 -%}
              {%- assign _range_end = 0 -%}
              {%- assign _additional_days = 0 %}
          {% endif %}
          {% if debug._parameter_value == 'true' %}
              -- *****************************************
              -- Compare To:       {{_compare_to_period}}
              -- Range Size:       {{_range_size}}
              -- Additional Days:  {{ _additional_days }}
              -- *****************************************
          {%- endif %}
          case
          {% for i in (1.._period_count) %}
            {% if debug._parameter_value == 'true' %}
              -- *****************************************
              -- Range Start:      {{ _range_start }}
              -- Range End:        {{ _range_end }}
              -- *****************************************
            {%- endif %}
            {%- if i == 1 %}
            when ${event_date_tz_convert} between date_add('days', -{{- _range_start -}}, ${start_date_dim}) and date_add('days', -{{- _range_end -}}, ${end_date_dim}) then datediff('seconds', date_add('days', -{{- _range_start -}}, ${start_date_dim}), ${event_date_tz_convert})
            {%- endif -%}
            {%- if i != 1 %}
              {%- case _compare_to_period %}
                {%- when 'prior_period' %}
                    when ${event_date_tz_convert} between date_add('days', -{{- _range_start -}}, ${start_date_dim}) and date_add('days', -{{- _range_end | minus: 1 -}}, ${end_date_dim}) then datediff('seconds', date_add('days', -{{- _range_start -}}, ${start_date_dim}), ${event_date_tz_convert})

                {%- when 'prior_week' %}
                    when ${event_date_tz_convert} between date_add('w',   -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('w',   -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then datediff('seconds', date_add('w',   -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})), ${event_date_tz_convert})

                {%- when 'prior_month' %}
                  {%- if _normalize_range_size == 'true' %}
                    when ${event_date_tz_convert} between date_add('days', -{{- i | minus: 1 | times: 28}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('days', -{{- i | minus: 1 | times: 28}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then datediff('seconds', date_add('days', -{{- i | minus: 1 | times: 28}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})), ${event_date_tz_convert})

                  {%- elsif _normalize_range_size != 'true' %}
                    when ${event_date_tz_convert} between date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then datediff('seconds',date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})), ${event_date_tz_convert})
                  {%- endif -%}

                {%- when 'prior_quarter' %}
                  {%- if _normalize_range_size == 'true' -%}
                    when ${event_date_tz_convert} between date_add('days', -{{- i | minus: 1 | times: 91}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('days', -{{- i | minus: 1 | times: 91}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then datediff('seconds', date_add('days', -{{- i | minus: 1 | times: 91}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})), ${event_date_tz_convert})

                  {%- elsif _normalize_range_size != 'true' %}
                    when ${event_date_tz_convert} between date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and  date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then datediff('seconds', date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})), ${event_date_tz_convert})
                  {%- endif -%}

                {%- when 'prior_year' %}
                  {%- if _normalize_range_size == 'true' -%}
                    when ${event_date_tz_convert} between date_add('days', -{{- i | minus: 1 | times: 365}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('days', -{{- i | minus: 1 | times: 365}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then datediff('seconds', date_add('days', -{{- i | minus: 1 | times: 365}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})), ${event_date_tz_convert})

                  {%- elsif _normalize_range_size != 'true' %}
                    when ${event_date_tz_convert} between date_add('yrs', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('yrs', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim})) then datediff('seconds', date_add('yrs', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})), ${event_date_tz_convert})
                  {%- endif -%}
              {%- endcase -%}
            {%- endif -%}
            {%- if _compare_to_period == 'prior_period' -%}
              {%- assign _i_plus_one = i | plus: 1 -%}
              {%- assign _range_end = _range_start | plus: 1  -%}
              {%- assign _range_start = _range_size | times: _i_plus_one | plus: _additional_days | floor -%}
            {%- endif -%}
          {% endfor %}
          end;;
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
          {%- assign _period_selection = period_selection._parameter_value -%}
          {%- assign _normalize_range_size = normalize_range_size._parameter_value -%}
          {%- assign _period_count = period_count._parameter_value | times: 1 -%}
          {%- assign _additional_days = 0 -%}
          {%- if _period_selection == "today" -%}
              {%- assign _range_size = 1 -%}
              {%- assign _range_start = _range_size -%}
              {%- assign _range_end = 0 -%}
              {%- assign _end_period_value = 0 -%}
          {%- elsif _period_selection == "yesterday" -%}
              {%- assign _range_size = 1 -%}
              {%- assign _range_start = 2 -%}
              {%- assign _range_end = 1 -%}
              {%- assign _additional_days = 1 %}
          {%- elsif _period_selection == "wtd" or _period_selection == "mtd" or _period_selection == "qtd" or _period_selection == "ytd" -%}
              {%- assign _range_size = 0 -%}
              {%- assign _range_start = 0 -%}
              {%- assign _range_end = 0 -%}
              {%- assign _additional_days = 0 %}
          {%- endif -%}
          {% if debug._parameter_value == 'true' %}
              -- *****************************************
              -- Compare To:       {{_compare_to_period}}
              -- Range Size:       {{_range_size}}
              -- Additional Days:  {{ _additional_days }}
              -- *****************************************
          {%- endif %}
          {%- for i in (1.._period_count) %}
            {% if debug._parameter_value == 'true' %}
              -- *****************************************
              -- Range Start:      {{ _range_start }}
              -- Range End:        {{ _range_end }}
              -- *****************************************
            {%- endif %}
            {%- if i == 1 %}
                ${event_date_tz_convert} between date_add('days', -{{- _range_start -}}, ${start_date_dim}) and date_add('days', -{{- _range_end -}}, ${end_date_dim})
            {%- endif -%}
            {%- if i != 1 %}
              {%- case _compare_to_period %}
                {%- when 'prior_period' %}
                  or ${event_date_tz_convert} between date_add('days', -{{- _range_start -}}, ${start_date_dim}) and date_add('days', -{{- _range_end | minus: 1 -}}, ${end_date_dim})

                {%- when 'prior_week' %}
                  or ${event_date_tz_convert} between date_add('w',   -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('w',   -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim}))

                {%- when 'prior_month' %}
                  {%- if _normalize_range_size == 'true' %}
                    or ${event_date_tz_convert} between date_add('days', -{{- i | minus: 1 | times: 28}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('days', -{{- i | minus: 1 | times: 28}}, date_add('days', -{{- _range_end -}}, ${end_date_dim}))

                  {%- elsif _normalize_range_size != 'true' %}
                    or ${event_date_tz_convert} between date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('mon', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim}))
                  {%- endif -%}

                {%- when 'prior_quarter' %}
                  {%- if _normalize_range_size == 'true' %}
                    or ${event_date_tz_convert} between date_add('days', -{{- i | minus: 1 | times: 91}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('days', -{{- i | minus: 1 | times: 91}}, date_add('days', -{{- _range_end -}}, ${end_date_dim}))

                  {%- elsif _normalize_range_size != 'true' %}
                    or ${event_date_tz_convert} between date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim}))  and date_add('qtr', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim}))
                  {%- endif -%}

                {%- when 'prior_year' %}
                  {%- if _normalize_range_size == 'true' %}
                    or ${event_date_tz_convert} between date_add('days', -{{- i | minus: 1 | times: 365}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('days', -{{- i | minus: 1 | times: 365}}, date_add('days', -{{- _range_end -}}, ${end_date_dim}))

                  {%- elsif _normalize_range_size != 'true' %}
                    or ${event_date_tz_convert} between date_add('year', -{{- i | minus: 1}}, date_add('days', -{{- _range_start -}}, ${start_date_dim})) and date_add('year', -{{- i | minus: 1}}, date_add('days', -{{- _range_end -}}, ${end_date_dim}))
                  {%- endif -%}
              {%- endcase -%}
            {%- endif -%}
            {%- if _compare_to_period == 'prior_period' -%}
              {%- assign _i_plus_one = i | plus: 1 -%}
              {%- assign _range_end = _range_start | plus: 1  -%}
              {%- assign _range_start = _range_size | times: _i_plus_one | plus: _additional_days | floor -%}
            {%- endif -%}
          {% endfor %}
      {%- else -%}
        -- Period Control Block is not enabled for this query.
        1 = 1
      {%- endif -%};;
  }


}
