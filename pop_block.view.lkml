view: pop_block {
#  label: "Timeline Comparison Fields"

extension: required

dimension: getdate_func {
  hidden: yes
  description: "This only exists to be nested in the current_date dimension."
  type: date
  sql:getdate();;
  convert_tz: yes
}

dimension: current_date {
  view_label: "Timeline Comparison Fields"
  description: "This field exists because of the way Looker handles timezone conversions. If the conversion occurs after dateadd things get wonky and you get extra days."
  # type:
  hidden:  yes
  # Important note. This must be get_date, not current_date. current_date can't be timezone converted as it has no time. The system will assume midnight for the
  # conversion leading to bad results.
  sql: date({% case exclude_days._parameter_value %}
         {% when "999" %}
            (select max(${event_date}) from ${table_name})
         {% when "1" %}
            date_add('days', -1, ${getdate_func})
         {% when "2" %}
            date_add('days', -2, ${getdate_func})
         {% when "start_of_week" %}
            date_trunc('week', ${getdate_func})
         {% when "start_of_month" %}
            date_trunc('month', ${getdate_func})
         {% when "start_of_quarter" %}
            date_trunc('quarter', ${getdate_func})
         {% when "start_of_year" %}
            date_trunc('year', ${getdate_func})
         {% else %}
            ${getdate_func}
       {% endcase %});;
    # convert_tz: no
  }

  dimension: period_1_start_display {
    view_label: "Timeline Comparison Fields"
    group_label: "Debugging"
    type: date
    sql: ${period_1_start} ;;
    convert_tz: no
  }

  dimension: period_1_end_display {
    view_label: "Timeline Comparison Fields"
    group_label: "Debugging"
    type: date
    sql: ${period_1_end} ;;
    convert_tz: no
  }

  dimension: period_2_start_display {
    view_label: "Timeline Comparison Fields"
    group_label: "Debugging"
    type: date
    sql: ${period_2_start} ;;
    convert_tz: no
  }

  dimension: period_2_end_display {
    view_label: "Timeline Comparison Fields"
    group_label: "Debugging"
    type: date
    sql: ${period_2_end} ;;
    convert_tz: no
  }

  dimension: period_1_start {
    label: "Period 1 Start"
    view_label: "Timeline Comparison Fields"
    description: "Calculates the start of the current period"
    type: date_raw
    hidden:  yes
    # exclude_days value 999 = get last date that has data.
    sql: date({% case compare_to._parameter_value %}
          {% when "trailing" or "default" or "trailing_vs_prior_month" or "trailing_vs_prior_quarter" or "trailing_vs_prior_year" %}
            date(date_add('days', -(${size_of_range_dim}-1), ${current_date}))

          {% when "mtd_vs_prior_month" or "mtd_vs_prior_quarter" or "mtd_vs_prior_year" %}
            date(date_trunc('month', ${current_date}))

          {% when "qtd_vs_prior_quarter" or "qtd_vs_prior_year"%}
            date(date_trunc('quarter', ${current_date}))

          {% when "ytd_vs_prior_year" %}
            date(date_trunc('year', ${current_date}))

          {% when "last_month_vs_two_months_ago" %}
            date_trunc('month', dateadd('months', -1, ${current_date}))

          {% when "last_quarter_vs_two_quarters_ago" %}
            date_trunc('quarter', dateadd('quarter', -1, ${current_date}))

          {% when "last_year_vs_two_years_ago" %}
            date_trunc('year', dateadd('year', -1, ${current_date}))

        {% endcase %});;
  }

  dimension: period_1_end {
    label: "Period 1 End"
    view_label: "Timeline Comparison Fields"
    description: "Calculates the end of the current period"
    type: date_raw
    hidden:  yes
    sql: date({% case compare_to._parameter_value %}
          {% when "trailing" or "default" or "trailing_vs_prior_month"  or "trailing_vs_prior_quarter" or "trailing_vs_prior_year" or "yoy" or "mtd_vs_prior_month" or "mtd_vs_prior_quarter" or "mtd_vs_prior_year" or "qtd_vs_prior_quarter" or "qtd_vs_prior_year"  or "ytd_vs_prior_year"  %}
            ${current_date}

          {% when "last_month_vs_two_months_ago" %}
            dateadd('days', -1 ,dateadd('months', 1, ${period_1_start}))

          {% when "last_quarter_vs_two_quarters_ago" %}
            dateadd('days', -1 ,dateadd('quarter', 1, ${period_1_start}))

          {% when "last_year_vs_two_years_ago" %}
            dateadd('days', -1 ,dateadd('year', 1, ${period_1_start}))

        {% endcase %});;
  }

  dimension: period_2_start {
    view_label: "Timeline Comparison Fields"
    description: "Calculates the start of the previous period"
    type: date_raw
    hidden:  yes
    sql: date({% case compare_to._parameter_value %}
          {% when "trailing" or "default"  %}
            dateadd('days', -(${size_of_range_dim}), ${period_1_start})

          {% when "trailing_vs_prior_month" %}
            dateadd('days', -30, ${period_1_start})

          {% when "trailing_vs_prior_quarter" %}
            dateadd('days', -91, ${period_1_start})

          {% when "trailing_vs_prior_year" or "yoy" %}
            dateadd('days', -365, ${period_1_start})

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

          {% when "last_month_vs_two_months_ago" %}
            dateadd('days', -(datediff('days', ${period_1_start}, ${period_1_end})+1), ${period_1_start})

          {% when "last_quarter_vs_two_quarters_ago" %}
            dateadd('days', -(datediff('days', ${period_1_start}, ${period_1_end})+1), ${period_1_start})

          {% when "last_year_vs_two_years_ago" %}
            dateadd('days', -(datediff('days', ${period_1_start}, ${period_1_end})+1), ${period_1_start})

        {% endcase %});;
  }

  dimension: period_2_end {
    view_label: "Timeline Comparison Fields"
    description: "Calculates the end of the previous period"
    type: date_raw
    hidden:  yes
    sql: date({% case compare_to._parameter_value %}
            {% when "trailing" or "default" %}
              dateadd('days', -1, ${period_1_start})

            {% when "trailing_vs_prior_month" %}
              dateadd('days', -30, ${period_1_end})

            {% when "trailing_vs_prior_quarter" %}
              dateadd('days', -91, ${period_1_end})

            {% when "trailing_vs_prior_year" or "yoy" %}
              dateadd('days', -365, ${period_1_end})

            {% when "mtd_vs_prior_month" or "mtd_vs_prior_quarter" or "mtd_vs_prior_year" or "qtd_vs_prior_quarter" or "qtd_vs_prior_year" or "ytd_vs_prior_year" %}
              dateadd('days', (datediff('days', ${period_1_start}, ${period_1_end})), ${period_2_start})

            {% when "last_month_vs_two_months_ago" %}
              dateadd('days', -(datediff('days', ${period_1_start}, ${period_1_end})+1), ${period_1_end})

            {% when "last_quarter_vs_two_quarters_ago" %}
              dateadd('days', -(datediff('days', ${period_1_start}, ${period_1_end})+1), ${period_1_end})

            {% when "last_year_vs_two_years_ago" %}
              dateadd('days', -(datediff('days', ${period_1_start}, ${period_1_end})+1), ${period_1_end})

          {% endcase %});;
  }

  dimension: period_3_start {
    view_label: "Timeline Comparison Fields"
    description: "Calculates the start of 2 periods ago"
    type: date_raw
    sql: date({% case compare_to._parameter_value %}
          {% when "trailing" or "default"  %}
            dateadd('days', -(${size_of_range_dim}), ${period_2_start})

          {% when "trailing_vs_prior_month" %}
            dateadd('days', -30, ${period_2_start})

          {% when "trailing_vs_prior_quarter" %}
            dateadd('days', -91, ${period_2_start})

          {% when "trailing_vs_prior_year" or "yoy" %}
            dateadd('days', -365, ${period_2_start})

          {% when "mtd_vs_prior_month" %}
              dateadd('days', -(datediff('days', ${period_2_start}, dateadd('months', 1, ${period_2_start}))), ${period_2_start})

          {% when "mtd_vs_prior_quarter" %}
            dateadd('days', -(datediff('days', ${period_2_start}, dateadd('quarters', 1, ${period_2_start}))), ${period_2_start})

          {% when "mtd_vs_prior_year" %}
            dateadd('days', -365, ${period_2_start})

          {% when "qtd_vs_prior_quarter" %}
            dateadd('days', -(datediff('days', ${period_2_start}, dateadd('quarters', 1, ${period_2_start}))), ${period_2_start})

          {% when "qtd_vs_prior_year" %}
            dateadd('days', -365, ${period_2_start})

          {% when "ytd_vs_prior_year" %}
            dateadd('days', -365, ${period_2_start})

          {% when "last_month_vs_two_months_ago" %}
            dateadd('days', -(datediff('days', ${period_2_start}, ${period_2_end})+1), ${period_2_start})

          {% when "last_quarter_vs_two_quarters_ago" %}
            dateadd('days', -(datediff('days', ${period_2_start}, ${period_2_end})+1), ${period_2_start})

          {% when "last_year_vs_two_years_ago" %}
            dateadd('days', -(datediff('days', ${period_2_start}, ${period_2_end})+1), ${period_2_start})

        {% endcase %});;
    hidden: yes

  }

  dimension: period_3_end {
    view_label: "Timeline Comparison Fields"
    description: "Calculates the end of 2 periods ago"
    type: date_raw
    sql:  date({% case compare_to._parameter_value %}
            {% when "trailing" or "default" %}
              dateadd('days', -1, ${period_2_start})

            {% when "trailing_vs_prior_month" %}
              dateadd('days', -30, ${period_2_end})

            {% when "trailing_vs_prior_quarter" %}
              dateadd('days', -91, ${period_2_end})

            {% when "trailing_vs_prior_year" or "yoy" %}
              dateadd('days', -365, ${period_2_end})

            {% when "mtd_vs_prior_month" or "mtd_vs_prior_quarter" or "mtd_vs_prior_year" or "qtd_vs_prior_quarter" or "qtd_vs_prior_year" or "ytd_vs_prior_year" %}
              dateadd('days', (datediff('days', ${period_2_start}, ${period_2_end})), ${period_3_start})

            {% when "last_month_vs_two_months_ago" %}
              dateadd('days', -(datediff('days', ${period_2_start}, ${period_2_end})+1), ${period_2_end})

            {% when "last_quarter_vs_two_quarters_ago" %}
              dateadd('days', -(datediff('days', ${period_2_start}, ${period_2_end})+1), ${period_2_end})

            {% when "last_year_vs_two_years_ago" %}
              dateadd('days', -(datediff('days', ${period_2_start}, ${period_2_end})+1), ${period_2_end})

          {% endcase %});;
    hidden: yes
  }

  dimension: period_4_start {
    view_label: "Timeline Comparison Fields"
    description: "Calculates the start of 4 periods ago"
    type: date_raw
    sql: -- Todo
    ;;
    hidden: yes
  }

  dimension: period_4_end {
    view_label: "Timeline Comparison Fields"
    description: "Calculates the end of 4 periods ago"
    type: date_raw
    sql: --todo
    ;;
    hidden: yes
  }

  parameter: size_of_range {
    description: "How many days in your period?"
    label: "1. Days in period"
    type: unquoted
    default_value: "0"
    view_label: "Timeline Comparison Fields"
  }

  parameter: exclude_days {
    description: "Select days to exclude"
    label: "2. Exclude Days:"
    view_label: "Timeline Comparison Fields"
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
    default_value: "0"
  }

  parameter: compare_to {
    label: "3. Compare to"
    view_label: "Timeline Comparison Fields"
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
      label: "Trailing vs Same Period Prior Month"
      value: "trailing_vs_prior_month"
    }
    allowed_value: {
      label: "Trailing vs Same Period Prior Quarter"
      value: "trailing_vs_prior_quarter"
    }
    allowed_value: {
      label: "Trailing vs Same Period Prior Year"
      value: "trailing_vs_prior_year"
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
    label: "4. Number of Periods"
    view_label: "Timeline Comparison Fields"
    description: "Choose the number of periods you would like to compare - defaults to 2. Only works with templated periods from step 2."
    type: number
    allowed_value: {
      label: "2"
      value: "2"
    }
    allowed_value: {
      label: "3"
      value: "3"
    }
    # allowed_value: {
    #   label: "4"
    #   value: "4"
    # }
    default_value: "2"
  }


  dimension: size_of_range_dim {
    view_label: "size_of_range_dim"
    hidden: yes
    sql: {% parameter size_of_range %} ;;
    type: number
  }

  dimension: comparison_periods_dim {
    view_label: "comparison_periods_dim"
    hidden: yes
    sql: {% parameter comparison_periods %} ;;
    type: number
  }

  dimension: exclude_days_dim {
    view_label: "exclude_days_dim"
    hidden: yes
    sql: {% parameter exclude_days %} ;;
    type: number
  }


  dimension: period {
    view_label: "Timeline Comparison Fields"
    label: "Period Pivot"
    group_label: "Pivot Dimensions"
    description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period', 'Previous Period' or 'Last Year', '2 Years Ago'"
    type: string
    order_by_field: order_for_period
    sql:   case
             when ${event_date} between ${period_1_start} and ${period_1_end} then

              {% case compare_to._parameter_value %}
                {% when "trailing" or "default" or "trailing_vs_prior_month" or "trailing_vs_prior_quarter" or "trailing_vs_prior_year" or "yoy" %}
                  'This Period'

                {% when "mtd_vs_prior_month" or "mtd_vs_prior_quarter" or "mtd_vs_prior_year"  %}
                  'This Month'

                {% when "qtd_vs_prior_quarter" or "qtd_vs_prior_year" %}
                  'This Quarter'

                {% when "ytd_vs_prior_year" %}
                  'This Year'

                {% when "last_month_vs_two_months_ago" %}
                  'Last Month'

                {% when "last_quarter_vs_two_quarters_ago" %}
                  'Last Quarter'

                {% when "last_year_vs_two_years_ago" %}
                  'Last Year'
              {% endcase %}  || ' (' || ${period_1_start} || ' to ' ||  ${period_1_end} || ')'

             when ${event_date} between ${period_2_start} and ${period_2_end} then
              {% case compare_to._parameter_value %}
                {% when "trailing" or "default" %}
                  'Prior Period'
                {% when "trailing_vs_prior_month" %}
                  'Period Last Month'

                {% when "trailing_vs_prior_quarter" %}
                  'Period Last Quarter'

                {% when "trailing_vs_prior_year" or "yoy" %}
                  'Period Prior Year'

                {% when "mtd_vs_prior_month" %}  %}
                  'Prior Month'

                {% when "qtd_vs_prior_quarter" or "qtd_vs_prior_year" or "mtd_vs_prior_quarter"%}
                  'Prior Quarter'

                {% when "ytd_vs_prior_year" or "mtd_vs_prior_year" %}
                  'Prior Year'

                {% when "last_month_vs_two_months_ago" %}
                  'Two Months Ago'

                {% when "last_quarter_vs_two_quarters_ago" %}
                  'Two Quarters Ago'

                {% when "last_year_vs_two_years_ago" %}
                  'Two Years Ago'

              {% endcase %}   || ' (' || ${period_2_start} || ' to ' ||  ${period_2_end} || ')'
          {% if comparison_periods._parameter_value == "4" or comparison_periods._parameter_value == "3"%}
            when ${event_date} between ${period_3_start} and ${period_3_end} then
              {% case compare_to._parameter_value %}
                {% when "trailing" or "default" %}
                  '3 Periods Ago'
                {% when "trailing_vs_prior_month" %}
                  'Period 3 Months Ago'

                {% when "trailing_vs_prior_quarter" %}
                  'Period 3 Quarters Ago'

                {% when "trailing_vs_prior_year" or "yoy" %}
                  'Period 3 Years Ago'

                {% when "mtd_vs_prior_month" %}  %}
                  '3 Months Ago'

                {% when "qtd_vs_prior_quarter" or "qtd_vs_prior_year" or "mtd_vs_prior_quarter"%}
                  '3 Quarters Ago'

                {% when "ytd_vs_prior_year" or "mtd_vs_prior_year" %}
                  '3 Years Ago'

                {% when "last_month_vs_two_months_ago" %}
                  'Three Months Ago'

                {% when "last_quarter_vs_two_quarters_ago" %}
                  'Three Quarters Ago'

                {% when "last_year_vs_two_years_ago" %}
                  'Three Years Ago'
              {% endcase %}
          {% endif %}
          {% if comparison_periods._parameter_value == "4" %}
            when ${event_date} between ${period_4_start} and ${period_4_end} then
                {% case compare_to._parameter_value %}
                  {% when "trailing" or "default" %}
                    '4 Periods Ago'
                  {% when "trailing_vs_prior_month" %}
                    'Period 4 Months Ago'

                  {% when "trailing_vs_prior_quarter" %}
                    'Period 4 Quarters Ago'

                  {% when "trailing_vs_prior_year" or "yoy" %}
                    'Period 4 Years Ago'

                  {% when "mtd_vs_prior_month" %}  %}
                    '4 Months Ago'

                  {% when "qtd_vs_prior_quarter" or "qtd_vs_prior_year" or "mtd_vs_prior_quarter"%}
                    '4 Quarters Ago'

                  {% when "ytd_vs_prior_year" or "mtd_vs_prior_year" %}
                    '4 Years Ago'

                  {% when "last_month_vs_two_months_ago" %}
                    'Four Months Ago'

                  {% when "last_quarter_vs_two_quarters_ago" %}
                    'Four Quarters Ago'

                  {% when "last_year_vs_two_years_ago" %}
                    'Four Years Ago'
                {% endcase %}
            {% endif %}
           end ;;
  }



  # Someday - How to make date math using Liquid. https://stackoverflow.com/questions/21056965/date-math-manipulation-in-liquid-template-filter
  # Could use this to fill in the dates on the period labels!
  # dimension: period_with_dates {
  #   view_label: "Timeline Comparison Fields"
  #   label: "Period Pivot With Dates"
  #   group_label: "Pivot Dimensions"
  #   description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period', 'Previous Period' or '3 Periods Ago'"
  #   type: string
  #   order_by_field: order_for_period
  #   sql:   case
  #           when ${event_date} between ${period_1_start} and ${period_1_end}
  #           then {% if parameter compare_to == 'YoY' %}'This Year'{% else %}'This Period'{% endif %}
  #           when ${event_date} between ${period_2_start} and ${period_2_end}
  #           then {% if parameter compare_to == 'YoY' %}'This Period Last Year'{% else %}'Last Period'{% endif %}
  #           {% if comparison_periods._parameter_value == "3" or comparison_periods._parameter_value == "4" %}
  #           when ${event_date} between ${period_3_start} and ${period_3_end}
  #           then {% if parameter compare_to == 'YoY' %}'This Period 2 Years Ago'{% else %}'2 Periods Ago'{% endif %}
  #           {% endif %}
  #           {% if comparison_periods._parameter_value == "4" %}
  #           when ${event_date} between ${period_4_start} and ${period_4_end}
  #           then {% if parameter compare_to == 'YoY' %}'This Period 3 Years'{% else %}'2 Periods Ago'{% endif %}
  #           {% endif %}
  #         end ;;
  # }


  dimension: order_for_period {
    hidden: yes
    view_label: "Timeline Comparison Fields"
    label: "Period"
    description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period', 'Previous Period' or '3 Periods Ago'"
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

  # dimension: date_in_period {
  #   description: "Use this as your date dimension when comparing periods. Aligns the all previous periods onto the current period"
  #   label: "Date in Period"
  #   group_label: "X Axis Dimensions"
  #   type: date
  #   sql: dateadd('day', ${day_in_period}, ${period_1_start}) ;;
  #   view_label: "Timeline Comparison Fields"
  #   convert_tz: no
  # }

  dimension_group: date_in_period {
    description: "Use this as your date dimension when comparing periods. Aligns the all previous periods onto the current period"
    label: "Date in Period"
    group_label: "X Axis Dimensions"
    type: time
    timeframes: [date, quarter, year, month, week, day_of_week,fiscal_month_num, fiscal_quarter, quarter_of_year]
    sql: dateadd('day', ${day_in_period}, ${period_1_start}) ;;
    view_label: "Timeline Comparison Fields"
    convert_tz: no
  }

  dimension: date_last_period {
    description: "This can be added as a hidden column to display the value of the date 2 periods ago. Only works for 2 periods ago."
    label: "Date Last Period"
    group_label: "Debugging"
    type: date
    sql: dateadd('day', ${day_in_period}, ${period_2_start}) ;;
    view_label: "Timeline Comparison Fields"
    convert_tz: no
  }

  dimension: date_3_period {
    description: "This can be added as a hidden column to display the value of the date 2 periods ago. Only works for 3 periods ago."
    label: "Date 3 Periods Ago"
    group_label: "Debugging"
    type: date
    sql: dateadd('day', ${day_in_period}, ${period_3_start}) ;;
    view_label: "Timeline Comparison Fields"
    convert_tz: no
  }


  dimension: day_in_period {
    view_label: "Timeline Comparison Fields"
    group_label: "X Axis Dimensions"
    description: "Gives the number of days since the start of each periods. Use this to align the event dates onto the same axis, the axes will read 1,2,3, etc."
    type: number
    sql:case
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
    hidden: no
  }
}
