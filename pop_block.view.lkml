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


view: pop_block {

  extension: required

# *********
# Ideas / To-Do List:
#
# 1. Create a setting option (set in the view), that allows for absolute time units to be turned on. A month with 30 days would be compared
#    to a month with 31 days. A leap year would count as all 366 days.
# 2. Get the timeline tile working so periods can be visualized.
# 3. Research if it's possible to use the data validation tests as a form of unit test for the PoP block code. Check if dates are as expected, or if periods are same len.


# *************************
# Filters / Parameters
# *************************

  parameter: as_of_date {
    label: "As of Date"
    description: "Use this to change the value of the current date. Setting to a date will change the tile/dashboard to act as if today is the selected date."
    type: date
    group_label: "Dashboard User Selection"
    view_label: "@{block_field_name}"
  }

  parameter: size_of_range {
    description: "How many days in your period (trailing only)?"
    label: "Number of Trailing Days"
    group_label: "Tile or Explore Filters"
    type: unquoted
    default_value: "0"
    view_label: "@{block_field_name}"
  }

  parameter: user_size_of_range {
    description: "How many days in your period (trailing only)?"
    label: "Number of Trailing Days"
    group_label: "Dashboard User Selection"
    type: unquoted
    default_value: "0"
    view_label: "@{block_field_name}"
  }

  parameter: exclude_days {
    description: "Select days to exclude"
    label: "Tile Exclude Days"
    group_label: "Tile or Explore Filters"
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

# Dashboard version of Exclude Days filter
  parameter: user_exclude_days {
    description: "Select days to exclude"
    label: "Exclude Days"
    group_label: "Dashboard User Selection"
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

  parameter: user_exclude_tile_override_dashboard {
    description: "Setting this to Override will cause the tile level exclude days selection to override any dashboard level selection"
    label: "Override Dashboard Exclude Days"
    view_label: "@{block_field_name}"
    group_label: "Tile or Explore Filters"
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

  parameter: tile_snap_start_date_to {
    label: "Tile: Snap Start Date to"
    description: "Setting this filter will ensure that the start date includes the begining of the selected period. For example, if you selected trailing 365, the first month might be partial. Selecting snap to month would ensure a complete first month."
    view_label: "@{block_field_name}"
    group_label: "Tile or Explore Filters"
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


  parameter: user_snap_start_date_to {
    label: "Snap Start Date to"
    description: "Setting this filter will ensure that the start date includes the begining of the selected period. For example, if you selected trailing 365, the first month might be partial. Selecting snap to month would ensure a complete first month."
    view_label: "@{block_field_name}"
    group_label: "Dashboard User Selection"
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

  dimension: snap_dim {
    # Allows for output of snap to value
    hidden: yes
    type: string
    sql:
    {% if user_snap_start_date_to._parameter_value != "none" %}
      '{% parameter user_snap_start_date_to %}'
    {% elsif tile_snap_start_date_to._parameter_value != "none" %}
      '{% parameter tile_snap_start_date_to %}'
    {% endif %}
    ;;
  }


  parameter: compare_to {
    label: "Tile Period Selection"
    view_label: "@{block_field_name}"
    group_label: "Tile or Explore Filters"
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
      label: "Trailing 7 Days"
      value: "trailing_7"
    }
    allowed_value: {
      label: "Trailing 14 Days"
      value: "trailing_14"
    }
    allowed_value: {
      label: "Trailing 28 Days"
      value: "trailing_28"
    }
    allowed_value: {
      label: "Trailing 30 Days"
      value: "trailing_30"
    }
    allowed_value: {
      label: "Trailing 90 Days"
      value: "trailing_90"
    }
    allowed_value: {
      label: "Trailing 180 Days"
      value: "trailing_180"
    }
    allowed_value: {
      label: "Trailing 365 Days"
      value: "trailing_365"
    }
    allowed_value: {
      label: "Trailing 7 Days vs Last Quarter"
      value: "trailing_7_lq"
    }
    allowed_value: {
      label: "Trailing 14 Days vs Last Quarter"
      value: "trailing_14_lq"
    }
    allowed_value: {
      label: "Trailing 28 Days vs Last Quarter"
      value: "trailing_28_lq"
    }
    allowed_value: {
      label: "Trailing 30 Days vs Last Quarter"
      value: "trailing_30_lq"
    }
    allowed_value: {
      label: "Trailing 7 Days vs Last Year"
      value: "trailing_7_ly"
    }
    allowed_value: {
      label: "Trailing 14 Days vs Last Year"
      value: "trailing_14_ly"
    }
    allowed_value: {
      label: "Trailing 28 Days vs Last Year"
      value: "trailing_28_ly"
    }
    allowed_value: {
      label: "Trailing 30 Days vs Last Year"
      value: "trailing_30_ly"
    }
    allowed_value: {
      label: "Trailing 90 Days vs Last Year"
      value: "trailing_90_ly"
    }
    allowed_value: {
      label: "Trailing 180 Days vs Last Year"
      value: "trailing_180_ly"
    }
    allowed_value: {
      label: "Today vs Yesterday"
      value: "today_vs_yesterday"
    }
    allowed_value: {
      label: "WTD vs Prior Week"
      value: "wtd_vs_prior_week"
    }
    allowed_value: {
      label: "MTD vs Prior Month"
      value: "mtd_vs_prior_month"
    }
    allowed_value: {
      label: "MTD vs Prior Quarter"
      value: "mtd_vs_prior_quarter"
    }
    allowed_value: {
      label: "MTD vs Prior Year"
      value: "mtd_vs_prior_year"
    }
    allowed_value: {
      label: "QTD vs Prior Quarter"
      value: "qtd_vs_prior_quarter"
    }
    allowed_value: {
      label: "QTD vs Prior Year"
      value: "qtd_vs_prior_year"
    }
    allowed_value: {
      label: "YTD vs Prior Year"
      value: "ytd_vs_prior_year"
    }
    allowed_value: {
      label: "Last Week Vs Two Weeks Ago"
      value: "last_week_vs_two_weeks_ago"
    }
    allowed_value: {
      label: "Last Month Vs Two Months Ago"
      value: "last_month_vs_two_months_ago"
    }
    allowed_value: {
      label: "Last Quarter Vs Two Quarters Ago"
      value: "last_quarter_vs_two_quarters_ago"
    }
    allowed_value: {
      label: "Last Year vs Two Years Ago"
      value: "last_year_vs_two_years_ago"
    }
    default_value: "none"
  }


  parameter: user_compare_to {
    label: "Period Selection"
    view_label: "@{block_field_name}"
    group_label: "Dashboard User Selection"
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
      label: "Trailing 7 Days"
      value: "trailing_7"
    }
    allowed_value: {
      label: "Trailing 14 Days"
      value: "trailing_14"
    }
    allowed_value: {
      label: "Trailing 28 Days"
      value: "trailing_28"
    }
    allowed_value: {
      label: "Trailing 30 Days"
      value: "trailing_30"
    }
    allowed_value: {
      label: "Trailing 90 Days"
      value: "trailing_90"
    }
    allowed_value: {
      label: "Trailing 180 Days"
      value: "trailing_180"
    }
    allowed_value: {
      label: "Trailing 365 Days"
      value: "trailing_365"
    }
    allowed_value: {
      label: "Trailing 7 Days vs Last Quarter"
      value: "trailing_7_lq"
    }
    allowed_value: {
      label: "Trailing 14 Days vs Last Quarter"
      value: "trailing_14_lq"
    }
    allowed_value: {
      label: "Trailing 28 Days vs Last Quarter"
      value: "trailing_28_lq"
    }
    allowed_value: {
      label: "Trailing 30 Days vs Last Quarter"
      value: "trailing_30_lq"
    }
    allowed_value: {
      label: "Trailing 7 Days vs Last Year"
      value: "trailing_7_ly"
    }
    allowed_value: {
      label: "Trailing 14 Days vs Last Year"
      value: "trailing_14_ly"
    }
    allowed_value: {
      label: "Trailing 28 Days vs Last Year"
      value: "trailing_28_ly"
    }
    allowed_value: {
      label: "Trailing 30 Days vs Last Year"
      value: "trailing_30_ly"
    }
    allowed_value: {
      label: "Trailing 90 Days vs Last Year"
      value: "trailing_90_ly"
    }
    allowed_value: {
      label: "Trailing 180 Days vs Last Year"
      value: "trailing_180_ly"
    }
    allowed_value: {
      label: "Today vs Yesterday"
      value: "today_vs_yesterday"
    }
    allowed_value: {
      label: "Yesterday vs Day Prior"
      value: "yesterday_vs_prior"
    }
    allowed_value: {
      label: "WTD vs Prior Week"
      value: "wtd_vs_prior_week"
    }
    allowed_value: {
      label: "MTD vs Prior Month"
      value: "mtd_vs_prior_month"
    }
    allowed_value: {
      label: "MTD vs Prior Quarter"
      value: "mtd_vs_prior_quarter"
    }
    allowed_value: {
      label: "MTD vs Prior Year"
      value: "mtd_vs_prior_year"
    }
    allowed_value: {
      label: "QTD vs Prior Quarter"
      value: "qtd_vs_prior_quarter"
    }
    allowed_value: {
      label: "QTD vs Prior Year"
      value: "qtd_vs_prior_year"
    }
    allowed_value: {
      label: "YTD vs Prior Year"
      value: "ytd_vs_prior_year"
    }
    allowed_value: {
      label: "Last Week Vs Two Weeks Ago"
      value: "last_week_vs_two_weeks_ago"
    }
    allowed_value: {
      label: "Last Month Vs Two Months Ago"
      value: "last_month_vs_two_months_ago"
    }
    allowed_value: {
      label: "Last Quarter Vs Two Quarters Ago"
      value: "last_quarter_vs_two_quarters_ago"
    }
    allowed_value: {
      label: "Last Year vs Two Years Ago"
      value: "last_year_vs_two_years_ago"
    }
    default_value: "none"
  }

  parameter: comparison_periods {
    label: "Number of Periods"
    group_label: "Tile or Explore Filters"
    view_label: "@{block_field_name}"
    description: "Choose the number of periods."
    type: number
    allowed_value: {
      label: "Select"
      value: "none"
    }
    allowed_value: {
      label: "2"
      value: "2"
    }
    allowed_value: {
      label: "3"
      value: "3"
    }
    allowed_value: {
      label: "4"
      value: "4"
    }
    default_value: "none"
  }

  parameter: display_dates_in_trailing_periods {
    group_label: "Tile or Explore Filters"
    view_label: "@{block_field_name}"
    description: "Display the dates alongside the periods. For example 'Current Period - 2021-01-01 to 2021-04-01'. Note that this will cause any custom colors set for the series to break when the dates change (i.e. the next day)."
    type: yesno
    default_value: "No"
  }

# *************************
# Related to "current date"
# *************************

  dimension: getdate_func {
    ##
    # Returns the value of the current date from Redshift with any timezone conversion added.
    #
    # It's important that the timezone conversion of "current date" only occurs once. This dimension is used by other dimensions to set the
    # current date.
    hidden: yes
    type: date
    sql: getdate();;
    convert_tz: yes
  }

  dimension: post_as_of_date {
    hidden: yes
    type: date
    sql:
      {% if as_of_date._parameter_value == 'NULL' %}
         ${getdate_func}
      {% else %}
        {% parameter as_of_date %}
      {% endif %};;
    convert_tz: no
  }

  dimension: current_date_dim {
    ##
    # This will return the date to be used as the end date for Period 1 with "exclude days" filters or "as date" options applied
    hidden:  yes
    sql:
      date(
        {% if as_of_date._parameter_value == 'NULL' and (user_exclude_days._parameter_value != '0' or exclude_days._parameter_value != '0') %}
          {% if user_exclude_days._parameter_value != '0' and user_exclude_tile_override_dashboard._parameter_value == '0' %}
              {% assign exclude_days_val = user_exclude_days._parameter_value %}
          {% else %}
              {% assign exclude_days_val = exclude_days._parameter_value %}
          {% endif %}
          {% case exclude_days_val %}
           {% when "999" %}
              -- Find max date in the available data and set to today. `origin_event_date` and `origin_table_name` are both set in the view.
              (select max(${origin_event_date}) from ${origin_table_name})
           {% when "1" %}
              dateadd('days', -1, ${post_as_of_date}) -- One day exclude
           {% when "2" %}
              dateadd('days', -2, ${post_as_of_date}) -- Two days exclude
           {% when "last_full_week" %}
              dateadd('days', -1, date_trunc('week', ${post_as_of_date})) -- Last full week
           {% when "last_full_month" %}
              dateadd('days', -1, date_trunc('month', ${post_as_of_date}))
           {% when "last_full_quarter" %}
              dateadd('days', -1, date_trunc('quarter', ${post_as_of_date}))
           {% when "last_full_year" %}
              dateadd('days', -1, date_trunc('year', ${post_as_of_date}))
               {% else %}
              ${post_as_of_date} -- No cases matched

          {% endcase %}

        {% else %}
            -- If as_of_date, exclude_days, and user_exclude_days are null
            -- User Exclude: {% parameter user_exclude_days %}|
            -- Regular exclude: {% parameter exclude_days %}|
            -- As of Date: {% parameter as_of_date %}
            ${post_as_of_date}
        {% endif %}
        )
        ;;
  }




    # *************************
    # Period Display Items
    # *************************

    dimension: period_1_start_display {
      view_label: "@{block_field_name}"
      group_label: "Period Display"
      type: date
      sql: ${period_1_start} ;;
      convert_tz: no
    }

    dimension: period_1_end_display {
      view_label: "@{block_field_name}"
      group_label: "Period Display"
      type: date
      sql: ${period_1_end} ;;
      convert_tz: no
    }

    dimension_group: period_1_duration_timeframe {
      view_label: "@{block_field_name}"
      group_label: "Period Display"
      description: "Displays the duration of period 1 in Looker timeframe format (i.e. 30 days, 2 weeks)"
      type: duration
      intervals: [day, week, month]
      sql_start: ${period_1_start} ;;
      sql_end: ${period_1_end} ;;
      convert_tz: no
    }

    measure: period_1_len {
      view_label: "@{block_field_name}"
      group_label: "Period Display"
      description: "Displays the duration of period 1 in days"
      type: number
      sql: datediff('days', ${period_1_start},${period_1_end}) ;;
    }

    dimension: period_2_start_display {
      view_label: "@{block_field_name}"
      group_label: "Period Display"
      type: date
      sql: ${period_2_start} ;;
      convert_tz: no
    }

    dimension: period_2_end_display {
      view_label: "@{block_field_name}"
      group_label: "Period Display"
      type: date
      sql: ${period_2_end} ;;
      convert_tz: no
    }

    measure: period_2_len {
      view_label: "@{block_field_name}"
      group_label: "Period Display"
      type: number
      sql: datediff('days', ${period_2_start},${period_2_end}) ;;
    }

    dimension: period_3_start_display {
      view_label: "@{block_field_name}"
      group_label: "Period Display"
      type: date
      sql: ${period_3_start} ;;
      convert_tz: no
    }

    dimension: period_3_end_display {
      view_label: "@{block_field_name}"
      group_label: "Period Display"
      type: date
      sql: ${period_3_end} ;;
      convert_tz: no
    }

    measure: period_3_len {
      view_label: "@{block_field_name}"
      group_label: "Period Display"
      type: number
      sql: datediff('days', ${period_3_start},${period_3_end}) ;;
    }

    dimension: period_4_start_display {
      view_label: "@{block_field_name}"
      group_label: "Period Display"
      type: date
      sql: ${period_4_start} ;;
      convert_tz: no
    }

    dimension: period_4_end_display {
      view_label: "@{block_field_name}"
      group_label: "Period Display"
      type: date
      sql: ${period_4_end} ;;
      convert_tz: no
    }

    measure: period_4_len {
      view_label: "@{block_field_name}"
      group_label: "Period Display"
      type: number
      sql: datediff('days', ${period_4_start},${period_4_end}) ;;
    }

    measure: period_len_check {
      view_label: "@{block_field_name}"
      description: "Used as check during testing to ensure that all periods are equal length."
      group_label: "Period Display"
      type: number
      sql: case
            when ${period_1_len} = ${period_2_len} and ${period_2_len} = ${period_3_len} and ${period_3_len} = ${period_4_len} then 'OK'
            else 'FAIL' end;;
    }

    dimension: selected_pop_type {
      type: string
      hidden: yes
      sql:
      {% assign comp_to = user_compare_to._parameter_value %}

      {% case user_compare_to._parameter_value %}
        {% when "trailing" or "trailing_7" or "trailing_14" or "trailing_28" or "trailing_30" or "trailing_90" or "trailing_180" or "trailing_365"
          or "trailing_7_lq" or "trailing_14_lq" or "trailing_28_lq" or "trailing_30_lq" or "trailing_90_lq" or "trailing_180_lq" or "trailing_365_lq"
          or "trailing_7_ly" or "trailing_14_ly" or "trailing_28_ly" or "trailing_30_ly" or "trailing_90_ly" or "trailing_180_ly" or "trailing_365_ly" %}
          'Trailing'
        {% when "today_vs_yesterday" %}
          'Today vs Yesterday'
        {% when "yesterday_vs_prior" %}
          'Yesterday vs Day Prior'
        {% when "wtd_vs_prior_week" %}
          'WTD vs Prior Week'
        {% when "mtd_vs_prior_month" %}
          'MTD vs Prior Month'
        {% when "mtd_vs_prior_quarter" %}
          'MTD vs Prior Quarter'
        {% when "mtd_vs_prior_year" %}
          'MTD vs Prior Year'
        {% when "qtd_vs_prior_quarter" %}
          'QTD vs Prior Quarter'
        {% when "qtd_vs_prior_year" %}
          'QTD Vs Prior Year'
        {% when "ytd_vs_prior_year" %}
          'YTD vs Prior Year'
        {% when "last_week_vs_two_weeks_ago" %}
          'Last Week vs Two Weeks Ago'
        {% when "last_month_vs_two_months_ago" %}
          'Last Month vs Two Months Ago'
        {% when "last_quarter_vs_two_quarters_ago" %}
          'Last Quarter vs Two Quarters Ago'
        {% when "last_year_vs_two_years_ago" %}
          'Last Year vs Two Years Ago'
        {% else %}
          'No Period Selected'
      {% endcase %};;
    }

  dimension: period_1_start_formatted {
    type: string
    sql: to_char(${period_1_start_display}, 'MM/DD/YY') ;;
}

  dimension: period_1_end_formatted {
    type: string
    sql: to_char(${period_1_end_display}, 'MM/DD/YY') ;;
  }

  dimension: period_2_start_formatted {
    type: string
    sql: to_char(${period_2_start_display}, 'MM/DD/YY') ;;
  }

  dimension: period_2_end_formatted {
    type: string
    sql: to_char(${period_2_end_display}, 'MM/DD/YY') ;;
  }

  dimension: period_date_display {
    view_label: "@{block_field_name}"
    description: "Use this with a single value type tile to display the current period block settings to the user."
    group_label: "Period Display"
    type: string
    sql: ${period_1_start_display} ;;
    html:
          <div style='float: left; padding:0 2% 0 2%; text-align:center;'>
            <table style='font-size:0.5em; line-height:1.2em; border-spacing: 10px;'>
               <tr><td style='text-align: right; color: gray;'>Current: </td><td><strong>{{ period_1_start_formatted}}</strong></td><td>&nbsp;to&nbsp;</td><td><strong>{{ period_1_end_formatted  }}</strong></td></tr>
               <tr><td style='text-align: right; color: gray;'>Prior: </td><td><strong>{{ period_2_start_formatted }}</strong></td><td>&nbsp;to&nbsp;</td><td><strong>{{ period_2_end_formatted }}</strong></td></tr>
            </table>
          </div>
            ;;
  }

  dimension: period_date_display_horizontal {
    view_label: "@{block_field_name}"
    description: "Use this with a single value type tile to display the current period block settings to the user."
    group_label: "Period Display"
    type: string
    sql: ${period_1_start_display} ;;
    html:
          <div style='float: left; padding:0 2% 0 2%; text-align:left;'>
            <table style='font-size:0.5em; line-height:1.2em; border-spacing: 10px;'>
               <tr><td style='text-align: right; color: gray;'>Current Period: </td><td><strong>{{ period_1_start }}</strong> to <strong>{{ period_1_end }}</strong></td><td>&nbsp;|&nbsp;</td>
               <td style='text-align: right; color: gray;'>Prior Period: </td><td><strong>{{ period_2_start }}</strong> to <strong>{{ period_2_end }}</strong></td></tr>
            </table>
          </div>
            ;;
  }

    dimension: period_explanation_display {
      view_label: "@{block_field_name}"
      description: "Use this with a single value type tile to display the current period block settings to the user."
      group_label: "Period Display"
      type: string
      sql: ${period_1_start_display} ;;
      html:
          <div style='text-align: center; width:100%;'>
            {% case user_compare_to._parameter_value %}
              {% when "trailing" or "trailing_7" or "trailing_14" or "trailing_28" or "trailing_30" or "trailing_90" or "trailing_180" or "trailing_365"
                or "trailing_7_lq" or "trailing_14_lq" or "trailing_28_lq" or "trailing_30_lq" or "trailing_90_lq" or "trailing_180_lq" or "trailing_365_lq"
                or "trailing_7_ly" or "trailing_14_ly" or "trailing_28_ly" or "trailing_30_ly" or "trailing_90_ly" or "trailing_180_ly" or "trailing_365_ly" %}
                <div style='float: left; padding-right:2%; border-right:2px solid gray; font-size: 0.75em;'>{{ selected_pop_type }} {{ period_1_len }} days</div>
              {% else %}
                <div style='float: left; padding-right:2%; border-right:2px solid gray; font-size: 0.75em;'>{{ selected_pop_type }}</div>
           {% endcase %}
            <div style='float: left; padding:0 2% 0 2%; text-align:left;'>
              <table style='font-size:0.5em; line-height:1.2em; border-spacing: 10px;'>
                 <tr><td style='text-align: right; color: gray;'>Current Period:</td><td><strong>{{ period_1_start }}</strong> to <strong>{{ period_1_end }}</strong></td></tr>
               <tr><td style='text-align: right; color: gray;'>Prior Period:</td><td><strong>{{ period_2_start }}</strong> to <strong>{{ period_2_end }}</strong></td></tr>
              </table>
            </div>
            <div style='float: left; padding-left:2%; border-left:2px solid gray; font-size: 0.75em; '><strong>{{ period_1_len }}</strong> days in period</div>
          </div>
            ;;
    }

    # *************************
    # Size of Range and Period
    # *************************


    dimension: size_of_range_dim {
      # Sets the size of the trailing range when "trailing" is selected. Note, this does not apply to the preset trailing items like trailing 30.
      hidden: yes
      sql:
          {% if user_size_of_range._parameter_value != "0" %}
            {% assign comp_value = user_size_of_range._parameter_value  %}
          {% else  %}
              {% assign comp_value = size_of_range._parameter_value  %}
          {% endif %}
          {{ comp_value}} ;;
      type: number
    }

    dimension: period {
      view_label: "@{block_field_name}"
      label: "Period Pivot"
      group_label: "Pivot Dimensions"
      description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period', 'Previous Period' or 'Last Year', '2 Years Ago'"
      type: string
      order_by_field: order_for_period
      # These were added to the end of each period, but this caused a bug in Looker. Because the series name changed each night the system ended up
      # falling back to the default colors. Now that the
      # || ' (' || ${period_1_start} || ' to ' ||  ${period_1_end} || ')'
      # || ' (' || ${period_2_start} || ' to ' ||  ${period_2_end} || ')'
      # || ' (' || ${period_3_start} || ' to ' ||  ${period_3_end} || ')'
      # || ' (' || ${period_4_start} || ' to ' ||  ${period_4_end} || ')'
      sql:
      case
           when ${event_date} between ${period_1_start} and ${period_1_end} then
              {% if user_compare_to._parameter_value != "none" %}
                {% assign comp_value = user_compare_to._parameter_value  %}
              {% else  %}
                {% assign comp_value = compare_to._parameter_value  %}
              {% endif %}
            {% case comp_value %}
              {% when "trailing" or "trailing_7" or "trailing_14" or "trailing_28" or "trailing_30" or "trailing_90" or "trailing_180" or "trailing_365"
                or "trailing_7_lq" or "trailing_14_lq" or "trailing_28_lq" or "trailing_30_lq" or "trailing_90_lq" or "trailing_180_lq" or "trailing_365_lq"
                or "trailing_7_ly" or "trailing_14_ly" or "trailing_28_ly" or "trailing_30_ly" or "trailing_90_ly" or "trailing_180_ly" or "trailing_365_ly" %}
                'This Period'
              {% when "today_vs_yesterday" %}
                'Today'
              {% when "yesterday_vs_prior" %}
                'Yesterday'
              {% when "wtd_vs_prior_week" %}
                'This Week'
              {% when "mtd_vs_prior_month" or "mtd_vs_prior_quarter" or "mtd_vs_prior_year"  %}
                'MTD - This Month'
              {% when "qtd_vs_prior_quarter" or "qtd_vs_prior_year" %}
                'QTD - This Quarter'
              {% when "ytd_vs_prior_year" %}
                'YTD - This Year'
              {% when 'last_week_vs_two_weeks_ago' %}
                'Last Week'
              {% when "last_month_vs_two_months_ago" %}
                'Last Month'
              {% when "last_quarter_vs_two_quarters_ago" %}
                'Last Quarter'
              {% when "last_year_vs_two_years_ago" %}
                'Last Year'
            {% endcase %}
            {% if display_dates_in_trailing_periods._parameter_value == 'true' %}
              || ' (' || ${period_1_start} || ' to ' ||  ${period_1_end} || ')'
            {% endif %}
             -- Debug: comp_value - {{ comp_value }}
           when ${event_date} between ${period_2_start} and ${period_2_end} then
            {% if user_compare_to._parameter_value != "none" %}
                {% assign comp_value = user_compare_to._parameter_value  %}
            {% else  %}
                {% assign comp_value = compare_to._parameter_value  %}
            {% endif %}

            {% case comp_value %}

              {% when "trailing" or "trailing_7" or "trailing_14" or "trailing_28" or "trailing_30" or "trailing_90" or "trailing_180" or "trailing_365" %}
                'Prior Period'
              {% when "trailing_7_lq" or "trailing_14_lq" or "trailing_28_lq" or "trailing_30_lq" or "trailing_90_lq" or "trailing_180_lq" or "trailing_365_lq" %}
                'Prior Quarter'
              {% when "trailing_7_ly" or "trailing_14_ly" or "trailing_28_ly" or "trailing_30_ly" or "trailing_90_ly" or "trailing_180_ly" or "trailing_365_ly" %}
                 'Prior Year'
              {% when "today_vs_yesterday" %}
                'Yesterday'
              {% when "yesterday_vs_prior" %}
                'Two Days Ago'
              {% when 'wtd_vs_prior_week' %}
                'Prior Week'
              {% when "mtd_vs_prior_month"%}
                'MTD - Prior Month'
              {% when "mtd_vs_prior_quarter"  %}
                  'MTD - Last Quarter'
              {% when "mtd_vs_prior_year"  %}
                  'MTD - Last Year'
              {% when "qtd_vs_prior_quarter" %}
                'QTD - Prior Quarter'
              {% when "qtd_vs_prior_year" %}
                'QTD - Same Quarter Last Year'
              {% when "ytd_vs_prior_year" %}
                'YTD - Prior Year'
              {% when 'last_week_vs_two_weeks_ago' %}
                'Two Weeks Ago'
              {% when "last_month_vs_two_months_ago" %}
                'Two Months Ago'
              {% when "last_quarter_vs_two_quarters_ago" %}
                'Two Quarters Ago'
              {% when "last_year_vs_two_years_ago" %}
                'Two Years Ago'
            {% endcase %}
            {% if display_dates_in_trailing_periods._parameter_value == 'true' %}
              || ' (' || ${period_2_start} || ' to ' ||  ${period_2_end} || ')'
            {% endif %}

        {% if comparison_periods._parameter_value == "4" or comparison_periods._parameter_value == "3"%}
          when ${event_date} between ${period_3_start} and ${period_3_end} then
            {% if user_compare_to._parameter_value != "none" %}
                {% assign comp_value = user_compare_to._parameter_value  %}
            {% else  %}
                {% assign comp_value = compare_to._parameter_value  %}
            {% endif %}
            {% case comp_value %}

              {% when "trailing" or "trailing_7" or "trailing_14" or "trailing_28" or "trailing_30" or "trailing_90" or "trailing_180" or "trailing_365" %}
                'Two Periods Ago'
              {% when "trailing_7_lq" or "trailing_14_lq" or "trailing_28_lq" or "trailing_30_lq" or "trailing_90_lq" or "trailing_180_lq" or "trailing_365_lq" %}
                'Two Quarters Ago'
              {% when "trailing_7_ly" or "trailing_14_ly" or "trailing_28_ly" or "trailing_30_ly" or "trailing_90_ly" or "trailing_180_ly" or "trailing_365_ly" %}
              'Two Years Ago'
              {% when "trailing" %}
                'Two Periods Ago'
              {% when "today_vs_yesterday" %}
                'Two Days Ago'
              {% when "yesterday_vs_prior" %}
                'Three Days Ago'
              {% when 'wtd_vs_prior_week' %}
                'Two Weeks Ago'
               {% when "mtd_vs_prior_month"%}
                'MTD - Two Months Ago'
              {% when "mtd_vs_prior_quarter"  %}
                'MTD - Two Quarters Ago'
              {% when "mtd_vs_prior_year"  %}
                'MTD - Two Years Ago'
              {% when "qtd_vs_prior_quarter" %}
                'QTD - Two Quarters Ago'
              {% when "qtd_vs_prior_year" %}
                'QTD - Same Quarter Two Years Ago'
              {% when "ytd_vs_prior_year" %}
                'Two Years Ago'
              {% when 'last_week_vs_two_weeks_ago' %}
                'Three Weeks Ago'
              {% when "last_month_vs_two_months_ago" %}
                'Three Months Ago'
              {% when "last_quarter_vs_two_quarters_ago" %}
                'Three Quarters Ago'
              {% when "last_year_vs_two_years_ago" %}
                'Three Years Ago'
            {% endcase %}
            {% if display_dates_in_trailing_periods._parameter_value == 'true' %}
              || ' (' || ${period_3_start} || ' to ' ||  ${period_3_end} || ')'
            {% endif %}

        {% endif %}
        {% if comparison_periods._parameter_value == "4" %}
          when ${event_date} between ${period_4_start} and ${period_4_end} then
            {% if user_compare_to._parameter_value != "none" %}
              {% assign comp_value = user_compare_to._parameter_value == 'true' %}
            {% else  %}
                {% assign comp_value = compare_to._parameter_value  %}
            {% endif %}

            {% case comp_value %}

              {% when "trailing" or "trailing_7" or "trailing_14" or "trailing_28" or "trailing_30" or "trailing_90" or "trailing_180" or "trailing_365" %}
                'Three Periods Ago'
              {% when "trailing_7_lq" or "trailing_14_lq" or "trailing_28_lq" or "trailing_30_lq" or "trailing_90_lq" or "trailing_180_lq" or "trailing_365_lq" %}
                'Three Quarters Ago'
              {% when "trailing_7_ly" or "trailing_14_ly" or "trailing_28_ly" or "trailing_30_ly" or "trailing_90_ly" or "trailing_180_ly" or "trailing_365_ly" %}
              'Three Years Ago'
              {% when "today_vs_yesterday" %}
                'Three Days Ago'
              {% when "yesterday_vs_prior" %}
                'Four Days Ago'
              {% when 'wtd_vs_prior_week' %}
                'Three Weeks Ago'
               {% when "mtd_vs_prior_month"%}
                'MTD - Three Months Ago'
              {% when "mtd_vs_prior_quarter" %}
                'MTD - Three Quarters Ago'
              {% when "mtd_vs_prior_year" %}
                'MTD - Three Years Ago'
              {% when "qtd_vs_prior_quarter" %}
                'QTD - Three Quarters Ago'
              {% when "qtd_vs_prior_year" %}
                'QTD - Same Quarter Three Years Ago'
              {% when "ytd_vs_prior_year" %}
                'Three Years Ago'
              {% when 'last_week_vs_two_weeks_ago' %}
                'Four Weeks Ago'
              {% when "last_month_vs_two_months_ago" %}
                'Four Months Ago'
              {% when "last_quarter_vs_two_quarters_ago" %}
                'Four Quarters Ago'
              {% when "last_year_vs_two_years_ago" %}
                'Four Years Ago'
            {% endcase %}
            {% if display_dates_in_trailing_periods._parameter_value == 'true' %}
              || ' (' || ${period_4_start} || ' to ' ||  ${period_4_end} || ')'
            {% endif %}

          {% endif %}
         end ;;
    }

# **********************************
# Pivot and X Axis Dimensions
# **********************************

    dimension: order_for_period {
      ###
      # Sets the order for period.
      #
      # This dimension is used to establish the proper sort order in the "period" dimension. A numeric sort is needed as the "period" dimension
      # displays human readable form such as "Last Month" or "Prior Period".
      hidden: yes
      type: string
      sql:   case
             when ${event_date} between ${period_1_start} and ${period_1_end} then 1
             when ${event_date} between ${period_2_start} and ${period_2_end} then 2
             {% if comparison_periods._parameter_value == "3" or comparison_periods._parameter_value == "4" %}
                when ${event_date} between ${period_3_start} and ${period_3_end} then 3
             {% endif %}
             {% if comparison_periods._parameter_value == "4" %}
                when ${event_date} between ${period_4_start} and ${period_4_end} then 4
             {% endif %}
         end ;;
    }

    dimension_group: date_in_period {
      ##
      # Date group used on X axis for time series analysis type charts.
      label: "Date in Period"
      view_label: "@{block_field_name}"
      group_label: "X Axis Dimensions"
      description: "Use this as your date dimension when comparing periods. Aligns the all previous periods onto the current period"
      type: time
      timeframes: [date, quarter, year, month, week, day_of_week,fiscal_month_num, fiscal_quarter, quarter_of_year]
      sql: dateadd('day', ${day_in_period}, ${period_1_start}) ;;
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
      sql:  case
            when ${event_date} between ${period_1_start} and ${period_1_end}
            then datediff('day', ${period_1_start}, ${event_date})
            when ${event_date} between ${period_2_start} and ${period_2_end}
            then datediff('day', ${period_2_start}, ${event_date})
            {% if comparison_periods._parameter_value == "3" or comparison_periods._parameter_value == "4" %}
            when ${event_date} between ${period_3_start} and ${period_3_end}
            then datediff('day', ${period_3_start}, ${event_date})
            {% endif %}
            {% if comparison_periods._parameter_value == "4" %}
            when ${event_date} between ${period_4_start} and ${period_4_end}
            then datediff('day', ${period_4_start}, ${event_date})
            {% endif %}
          end ;;
    }



# **********************************
# Period Dimensions
# **********************************

###
# All period start and end dimension calculate either the begining or ending date for a period.

    dimension: period_1_start {
      hidden:  yes
      description: "Calculates the start of the current period"
      type: date_raw
      sql:{% if user_compare_to._parameter_value != "none" %}
            {% assign comp_value = user_compare_to._parameter_value  %}
        {% else  %}
            {% assign comp_value = compare_to._parameter_value  %}
        {% endif %}

        date(
        {% if (user_snap_start_date_to._parameter_value != "none" or tile_snap_start_date_to._parameter_value != "none") and comp_value contains "trailing" %}
        {% comment %}
        -- If selected, will snap the start date to the begining of value (i.e. week, quarter, month, year)
        {% endcomment %}
            date_trunc(${snap_dim},
        {% endif %}

        {% case comp_value %}
              {% when "trailing" or "default"%}
                date_add('days', -(${size_of_range_dim}), ${current_date_dim})

              {% when "trailing_7" or "trailing_7_ly" or "trailing_7_lq" %}
                date_add('days', -(7), ${current_date_dim})

              {% when "trailing_14" or "trailing_14_ly" or "trailing_14_lq" %}
                date_add('days', -(14), ${current_date_dim})

              {% when "trailing_28" or "trailing_28_ly" or "trailing_28_lq" %}
                date_add('days', -(28), ${current_date_dim})

              {% when "trailing_30" or "trailing_30_ly" or "trailing_30_lq" %}
                date_add('days', -(30), ${current_date_dim})

              {% when "trailing_90" or "trailing_90_ly"  %}
                date_add('days', -(90), ${current_date_dim})

              {% when "trailing_180" or "trailing_180_ly"  %}
                date_add('days', -(180), ${current_date_dim})

              {% when "trailing_365" or "trailing_365_ly" %}
                date_add('days', -(365), ${current_date_dim})

              {% when "today_vs_yesterday" %}
                date_add('days', -(1), ${current_date_dim})
              {% when "yesterday_vs_prior" %}
                date_add('days', -(2), ${current_date_dim})

              {% when "wtd_vs_prior_week" %}
                date_trunc('week', ${current_date_dim})

              {% when "mtd_vs_prior_month" or "mtd_vs_prior_quarter" or "mtd_vs_prior_year" %}
                date_trunc('month', ${current_date_dim})

              {% when "qtd_vs_prior_quarter" or "qtd_vs_prior_year"%}
                date_trunc('quarter', ${current_date_dim})

              {% when "ytd_vs_prior_year" %}
                date_trunc('year', ${current_date_dim})

              {% when "last_week_vs_two_weeks_ago" %}
                date_trunc('week', dateadd('weeks', -1, ${current_date_dim}))

              {% when "last_month_vs_two_months_ago" %}
                date_trunc('month', dateadd('months', -1, ${current_date_dim}))

              {% when "last_quarter_vs_two_quarters_ago" %}
                date_trunc('quarter', dateadd('quarter', -1, ${current_date_dim}))

              {% when "last_year_vs_two_years_ago" %}
                date_trunc('year', dateadd('year', -1, ${current_date_dim}))

            {% endcase %}

        {% if (user_snap_start_date_to._parameter_value != "none" or tile_snap_start_date_to._parameter_value != "none") and comp_value contains "trailing" %}
          )
          {% comment %}
          -- close the snap to function
          {% endcomment %}
        {% endif %}
        )
        ;;
    }


    dimension: period_1_end {
      hidden:  yes
      type: date_raw

      sql:{% if user_compare_to._parameter_value != "none" %}
            {% assign comp_value = user_compare_to._parameter_value  %}
        {% else  %}
            {% assign comp_value = compare_to._parameter_value  %}
        {% endif %}

        date({% case comp_value %}
              {% when "trailing" or "trailing_7" or "trailing_14" or "trailing_28" or "trailing_30" or "trailing_90" or "trailing_180"
                or "trailing_365" or "trailing_7_lq" or "trailing_14_lq" or "trailing_28_lq" or "trailing_30_lq" or "trailing_90_lq"
                or "trailing_180_lq" or "trailing_365_lq" or "trailing_7_ly" or "trailing_14_ly" or "trailing_28_ly" or "trailing_30_ly"
                or "trailing_90_ly" or "trailing_180_ly" or "trailing_365_ly" or "mtd_vs_prior_month" or "wtd_vs_prior_week" or "mtd_vs_prior_quarter"
                or "mtd_vs_prior_year" or "qtd_vs_prior_quarter" or "qtd_vs_prior_year"  or "ytd_vs_prior_year" or "today_vs_yesterday" or "yesterday_vs_prior"%}
                ${current_date_dim}

              {% when "last_week_vs_two_weeks_ago" %}
                dateadd('days', -1 ,dateadd('weeks', 1, ${period_1_start}))

              {% when "last_month_vs_two_months_ago" %}
                dateadd('days', -1 ,dateadd('months', 1, ${period_1_start}))

              {% when "last_quarter_vs_two_quarters_ago" %}
                dateadd('days', -1 ,dateadd('quarter', 1, ${period_1_start}))

              {% when "last_year_vs_two_years_ago" %}
                dateadd('days', -1 ,dateadd('year', 1, ${period_1_start}))

            {% endcase %});;
    }

    dimension: period_2_start {
      view_label: "@{block_field_name}"
      description: "Calculates the start of the previous period"
      type: date_raw
      hidden:  yes
      sql:
        {% if user_compare_to._parameter_value != "none" %}
            {% assign comp_value = user_compare_to._parameter_value  %}
        {% else  %}
            {% assign comp_value = compare_to._parameter_value  %}
        {% endif %}
        date(
        {% if (user_snap_start_date_to._parameter_value != "none" or tile_snap_start_date_to._parameter_value != "none") and comp_value contains "trailing" %}
          {% comment %}
          -- If selected, will snap the start date to the begining of value (i.e. week, quarter, month, year)
          {% endcomment %}
            date_trunc(${snap_dim},
        {% endif %}

        {% case comp_value %}

              {% when "trailing" or "default"  %}
                dateadd('days', -(${size_of_range_dim}+1), ${period_1_start})

              {% when "trailing_7" %}
                dateadd('days', -8, ${period_1_start})

              {% when "trailing_14" %}
                dateadd('days', -15, ${period_1_start})

              {% when "trailing_28" %}
                dateadd('days', -29, ${period_1_start})

              {% when "trailing_30" %}
                dateadd('days', -31, ${period_1_start})

              {% when "trailing_90" %}
                dateadd('days', -91, ${period_1_start})

              {% when "trailing_180" %}
                dateadd('days', -181, ${period_1_start})

              {% when "trailing_365" or "yoy" %}
                dateadd('days', -366, ${period_1_start})

              {% when "trailing_7_lq" or "trailing_14_lq" or "trailing_28_lq" or "trailing_30_lq"%}
                  dateadd('days', -(datediff('days', ${period_1_start}, dateadd('quarters', 1, ${period_1_start}))), ${period_1_start})

              {% when "trailing_7_ly" or "trailing_14_ly" or "trailing_28_ly" or "trailing_30_ly" or "trailing_90_ly" or "trailing_180_ly" %}
                dateadd('days', -365, ${period_1_start})

              {% when "today_vs_yesterday" %}
                date_add('days', -(1), ${period_1_start})
              {% when "yesterday_vs_prior" %}
                date_add('days', -(2), ${period_1_start})

              {% when "wtd_vs_prior_week" %}
                dateadd('days', -(datediff('days', ${period_1_start}, dateadd('weeks', 1, ${period_1_start}))), ${period_1_start})

              {% when "mtd_vs_prior_month" %}
                  dateadd('days', -(datediff('days', ${period_1_start}, dateadd('months', 1, ${period_1_start}))), ${period_1_start})

              {% when "mtd_vs_prior_quarter" %}
                dateadd('days', -(datediff('days', ${period_1_start}, dateadd('quarters', 1, ${period_1_start}))), ${period_1_start})

              {% when "mtd_vs_prior_year" %}
                dateadd('days', -365, ${period_1_start})

              {% when "qtd_vs_prior_quarter" %}
                dateadd('days', -(datediff('days', ${period_1_start}, dateadd('quarters', 1, ${period_1_start}))), ${period_1_start})

              {% when "qtd_vs_prior_year" %}
                dateadd('days', -365, ${period_1_start})

              {% when "ytd_vs_prior_year" %}
                dateadd('days', -365, ${period_1_start})

              {% when "last_week_vs_two_weeks_ago" %}
                dateadd('days', -(datediff('days', ${period_1_start}, ${period_1_end})+1), ${period_1_start})

              {% when "last_month_vs_two_months_ago" %}
                dateadd('days', -(datediff('days', ${period_1_start}, ${period_1_end})+1), ${period_1_start})

              {% when "last_quarter_vs_two_quarters_ago" %}
                dateadd('days', -(datediff('days', ${period_1_start}, ${period_1_end})+1), ${period_1_start})

              {% when "last_year_vs_two_years_ago" %}
                dateadd('days', -(datediff('days', ${period_1_start}, ${period_1_end})+1), ${period_1_start})

            {% endcase %}
        {% if (user_snap_start_date_to._parameter_value != "none" or tile_snap_start_date_to._parameter_value != "none") and comp_value contains "trailing" %}
          )
          {% comment %}
          -- close the snap to function
          {% endcomment %}
        {% endif %}
        )
        ;;
    }

    dimension: period_2_end {
      view_label: "@{block_field_name}"
      description: "Calculates the end of the previous period"
      type: date_raw
      hidden:  yes
      sql:
        {% if user_compare_to._parameter_value != "none" %}
            {% assign comp_value = user_compare_to._parameter_value  %}
        {% else  %}
            {% assign comp_value = compare_to._parameter_value  %}
        {% endif %}

        date({% case comp_value %}
                {% when "trailing" or "default" or "trailing_7" or "trailing_14" or "trailing_28" or "trailing_30" or "trailing_90" or "trailing_180" or "trailing_365" or "today_vs_yesterday" or "yesterday_vs_prior" %}
                  dateadd('days', -1, ${period_1_start})
                {% when "trailing_7_lq" or "trailing_14_lq" or "trailing_28_lq" or "trailing_30_lq" or "trailing_7_ly" or "trailing_14_ly" or "trailing_28_ly" or "trailing_30_ly" or "trailing_90_ly" or "trailing_180_ly"%}
                  dateadd('days', (datediff('days', ${period_1_start}, ${period_1_end})), ${period_2_start})
                {% when "wtd_vs_prior_week" or "mtd_vs_prior_month" or "mtd_vs_prior_quarter" or "mtd_vs_prior_year" or "qtd_vs_prior_quarter" or "qtd_vs_prior_year" or "ytd_vs_prior_year"  %}
                  dateadd('days', (datediff('days', ${period_1_start}, ${period_1_end})), ${period_2_start})
                {% when "last_week_vs_two_weeks_ago" or "last_month_vs_two_months_ago" or "last_quarter_vs_two_quarters_ago" or "last_year_vs_two_years_ago"%}
                  dateadd('days', -(datediff('days', ${period_1_start}, ${period_1_end})+1), ${period_1_end})
              {% endcase %});;
    }

    dimension: period_3_start {
      view_label: "@{block_field_name}"
      description: "Calculates the start of 2 periods ago"
      type: date_raw
      sql:
        {% if user_compare_to._parameter_value != "none" %}
            {% assign comp_value = user_compare_to._parameter_value  %}
        {% else  %}
            {% assign comp_value = compare_to._parameter_value  %}
        {% endif %}
        date(
        {% if (user_snap_start_date_to._parameter_value != "none" or tile_snap_start_date_to._parameter_value != "none") and comp_value contains "trailing" %}
          {% comment %}
          -- If selected, will snap the start date to the begining of value (i.e. week, quarter, month, year)
          {% endcomment %}
            date_trunc(${snap_dim},
        {% endif %}
        -- period 3 comp_value: {{ comp_value }}
        {% case comp_value %}
                {% when "trailing" or "default"  %}
                  dateadd('days', -(${size_of_range_dim}+1), ${period_2_start})
                {% when "trailing_7" %}
                  dateadd('days', -8, ${period_2_start})
                {% when "trailing_14" %}
                  dateadd('days', -15, ${period_2_start})
                {% when "trailing_28" %}
                  dateadd('days', -29, ${period_2_start})
                {% when "trailing_30" %}
                  dateadd('days', -31, ${period_2_start})
                {% when "trailing_90" %}
                  dateadd('days', -91, ${period_2_start})
                {% when "trailing_180" %}
                  dateadd('days', -181, ${period_2_start})
                {% when "trailing_365" or "yoy" %}
                  dateadd('days', -366, ${period_2_start})
                {% when "trailing_7_lq" or "trailing_14_lq" or "trailing_28_lq" or "trailing_30_lq"%}
                  dateadd('days', -(datediff('days', ${period_2_start}, dateadd('quarters', 1, ${period_2_start}))), ${period_2_start})
                {% when "trailing_7_ly" or "trailing_14_ly" or "trailing_28_ly" or "trailing_30_ly" or "trailing_90_ly" or "trailing_180_ly" %}
                  dateadd('days', -365, ${period_2_start})
                {% when "today_vs_yesterday" %}
                  date_add('days', -(1), ${period_2_start})
                {% when "yesterday_vs_prior" %}
                  date_add('days', -(2), ${period_2_start})
                {% when "wtd_vs_prior_week" %}
                  dateadd('days', -(datediff('days', ${period_2_start}, dateadd('weeks', 1, ${period_2_start}))), ${period_2_start})
                {% when "mtd_vs_prior_month" %}
                  dateadd('days', -(datediff('days', ${period_2_start}, dateadd('months', 1, ${period_2_start}))), ${period_2_start})
                {% when "mtd_vs_prior_quarter" %}
                  dateadd('days', -(datediff('days', ${period_2_start}, dateadd('quarters', 1, ${period_2_start}))), ${period_2_start})
                {% when "mtd_vs_prior_year" %}
                  dateadd('days', -365, ${period_2_start})
                {% when "qtd_vs_prior_quarter" %}
                  dateadd('days', -(datediff('days', ${period_2_start}, dateadd('quarters', 1, ${period_2_start}))), ${period_2_start})
                {% when "qtd_vs_prior_year" or "ytd_vs_prior_year" %}
                  dateadd('days', -365, ${period_2_start})
                {% when "last_week_vs_two_weeks_ago" or "last_month_vs_two_months_ago" or "last_quarter_vs_two_quarters_ago" or "last_year_vs_two_years_ago" %}
                  dateadd('days', -(datediff('days', ${period_2_start}, ${period_2_end})+1), ${period_2_start})
              {% endcase %}

        {% if (user_snap_start_date_to._parameter_value != "none" or tile_snap_start_date_to._parameter_value != "none") and comp_value contains "trailing" %}
          )
          {% comment %}
          -- close the snap to function
          {% endcomment %}
        {% endif %}
        )
        ;;
      hidden: yes

    }

    dimension: period_3_end {
      view_label: "@{block_field_name}"
      description: "Calculates the end of 2 periods ago"
      type: date_raw
      sql:
          {% if user_compare_to._parameter_value != "none" %}
              {% assign comp_value = user_compare_to._parameter_value  %}
          {% else  %}
              {% assign comp_value = compare_to._parameter_value  %}
          {% endif %}

             date({% case comp_value %}
                  {% when "trailing" or "default" or "trailing_7" or "trailing_14" or "trailing_28" or "trailing_30" or "trailing_90" or "trailing_180" or "trailing_365" or "today_vs_yesterday" or "yesterday_vs_prior" %}
                    dateadd('days', -1, ${period_2_start})
                {% when "trailing_7_lq" or "trailing_14_lq" or "trailing_28_lq" or "trailing_30_lq" or "trailing_7_ly" or "trailing_14_ly" or "trailing_28_ly" or "trailing_30_ly" or "trailing_90_ly" or "trailing_180_ly"%}
                  dateadd('days', (datediff('days', ${period_2_start}, ${period_2_end})), ${period_3_start})
                  {% when "wtd_vs_prior_week" or "mtd_vs_prior_month" or "mtd_vs_prior_quarter" or "mtd_vs_prior_year" or "qtd_vs_prior_quarter" or "qtd_vs_prior_year" or "ytd_vs_prior_year" %}
                    dateadd('days', (datediff('days', ${period_2_start}, ${period_2_end})), ${period_3_start})
                  {% when "last_week_vs_two_weeks_ago" or "last_month_vs_two_months_ago" or "last_quarter_vs_two_quarters_ago" or "last_year_vs_two_years_ago"%}
                    dateadd('days', -(datediff('days', ${period_2_start}, ${period_2_end})+1), ${period_2_end})
                {% endcase %});;
      hidden: yes
    }

    dimension: period_4_start {
      view_label: "@{block_field_name}"
      description: "Calculates the start of 4 periods ago"
      type: date_raw
      sql:
          {% if user_compare_to._parameter_value != "none" %}
              {% assign comp_value = user_compare_to._parameter_value  %}
          {% else  %}
              {% assign comp_value = compare_to._parameter_value  %}
          {% endif %}
        date(
        {% if (user_snap_start_date_to._parameter_value != "none" or tile_snap_start_date_to._parameter_value != "none") and comp_value contains "trailing" %}
          {% comment %}
          -- If selected, will snap the start date to the begining of value (i.e. week, quarter, month, year)
          {% endcomment %}
            date_trunc(${snap_dim},
        {% endif %}
       {% case comp_value %}
                {% when "trailing" or "default"  %}
                  dateadd('days', -(${size_of_range_dim}+1), ${period_3_start})
                {% when "trailing_7" %}
                  dateadd('days', -8, ${period_3_start})
                {% when "trailing_14" %}
                  dateadd('days', -15, ${period_3_start})
                {% when "trailing_28" %}
                  dateadd('days', -29, ${period_3_start})
                {% when "trailing_30" %}
                  dateadd('days', -31, ${period_3_start})
                {% when "trailing_90" %}
                  dateadd('days', -91, ${period_3_start})
                {% when "trailing_180" %}
                  dateadd('days', -181, ${period_3_start})
                {% when "trailing_365" or "yoy" %}
                  dateadd('days', -366, ${period_3_start})
                {% when "trailing_7_lq" or "trailing_14_lq" or "trailing_28_lq" or "trailing_30_lq"%}
                  dateadd('days', -(datediff('days', ${period_3_start}, dateadd('quarters', 1, ${period_3_start}))), ${period_3_start})
                {% when "trailing_7_ly" or "trailing_14_ly" or "trailing_28_ly" or "trailing_30_ly" or "trailing_90_ly" or "trailing_180_ly" %}
                  dateadd('days', -365, ${period_3_start})
                {% when "today_vs_yesterday" %}
                date_add('days', -(1), ${period_3_start})
              {% when "yesterday_vs_prior" %}
                date_add('days', -(2), ${period_3_start})
                {% when "wtd_vs_prior_week" %}
                    dateadd('days', -(datediff('days', ${period_3_start}, dateadd('weeks', 1, ${period_3_start}))), ${period_3_start})
                {% when "mtd_vs_prior_month" %}
                    dateadd('days', -(datediff('days', ${period_3_start}, dateadd('months', 1, ${period_3_start}))), ${period_3_start})
                {% when "mtd_vs_prior_quarter" %}
                  dateadd('days', -(datediff('days', ${period_3_start}, dateadd('quarters', 1, ${period_3_start}))), ${period_3_start})
                {% when "mtd_vs_prior_year" %}
                  dateadd('days', -365, ${period_3_start})
                {% when "qtd_vs_prior_quarter" %}
                  dateadd('days', -(datediff('days', ${period_3_start}, dateadd('quarters', 1, ${period_3_start}))), ${period_3_start})
                {% when "qtd_vs_prior_year" %}
                  dateadd('days', -365, ${period_3_start})
                {% when "ytd_vs_prior_year" %}
                  dateadd('days', -365, ${period_3_start})
                {% when "last_week_vs_two_weeks_ago" or "last_month_vs_two_months_ago" or "last_quarter_vs_two_quarters_ago" or "last_year_vs_two_years_ago" %}
                  dateadd('days', -(datediff('days', ${period_3_start}, ${period_3_end})+1), ${period_3_start})
              {% endcase %}
        {% if (user_snap_start_date_to._parameter_value != "none" or tile_snap_start_date_to._parameter_value != "none") and comp_value contains "trailing" %}
          )
          {% comment %}
          -- close the snap to function
          {% endcomment %}
        {% endif %}
        );;
      hidden: yes
    }

    dimension: period_4_end {
      view_label: "@{block_field_name}"
      description: "Calculates the end of 4 periods ago"
      type: date_raw
      sql:
          {% if user_compare_to._parameter_value != "none" %}
              {% assign comp_value = user_compare_to._parameter_value  %}
          {% else  %}
              {% assign comp_value = compare_to._parameter_value  %}
          {% endif %}

             date({% case comp_value %}
                  {% when "trailing" or "default" or "trailing_7" or "trailing_14" or "trailing_28" or "trailing_30" or "trailing_90" or "trailing_180" or "trailing_365" or "today_vs_yesterday" or "yesterday_vs_prior" %}
                    dateadd('days', -1, ${period_3_start})
                   {% when "trailing_7_lq" or "trailing_14_lq" or "trailing_28_lq" or "trailing_30_lq" or "trailing_7_ly" or "trailing_14_ly" or "trailing_28_ly" or "trailing_30_ly" or "trailing_90_ly" or "trailing_180_ly"%}
                  dateadd('days', (datediff('days', ${period_3_start}, ${period_3_end})), ${period_4_start})
                  {% when "wtd_vs_prior_week" or "mtd_vs_prior_month" or "mtd_vs_prior_quarter" or "mtd_vs_prior_year" or "qtd_vs_prior_quarter" or "qtd_vs_prior_year" or "ytd_vs_prior_year" %}
                    dateadd('days', (datediff('days', ${period_3_start}, ${period_3_end})), ${period_4_start})
                  {% when "last_week_vs_two_weeks_ago" or "last_month_vs_two_months_ago" or "last_quarter_vs_two_quarters_ago" or "last_year_vs_two_years_ago" %}
                    dateadd('days', -(datediff('days', ${period_3_start}, ${period_3_end})+1), ${period_3_end})
                {% endcase %});;
      hidden: yes
    }


    # **********************
    # SQL Always Where

    dimension: sql_always_where_inject {
      hidden: yes
      sql:
          {% assign comp_val_set = compare_to._parameter_value %}
          {% assign user_comp_val_set = user_compare_to._parameter_value %}
          {% assign period_count = comparison_periods._parameter_value %}
          {% assign exclude_days_val = exclude_days._parameter_value %}
              {% if comp_val_set != "none" or user_comp_val_set != "none" %}
                {% case period_count %}
                  {% when 'none' %}
                    (${event_date} between ${period_1_start} and ${period_1_end})
                  {% when '2' %}
                    ((${event_date} between ${period_1_start} and ${period_1_end})
                    or (${event_date} between ${period_2_start} and ${period_2_end}))
                  {% when '3' %}
                    ((${event_date} between ${period_1_start} and ${period_1_end})
                    or (${event_date} between ${period_2_start} and ${period_2_end})
                    or (${event_date} between ${period_3_start} and ${period_3_end}))
                  {% when '4' %}
                    ((${event_date} between ${period_1_start} and ${period_1_end})
                    or (${event_date} between ${period_2_start} and ${period_2_end})
                    or (${event_date} between ${period_3_start} and ${period_3_end})
                    or (${event_date} between ${period_4_start} and ${period_4_end}))
                {% endcase %}
              {% else %}
                -- PoP Block is not in use. Default to 1=1 to avoid errors.
                1 = 1
              {% endif %};;
    }


  }
