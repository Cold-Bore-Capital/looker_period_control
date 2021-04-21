view: pop_block {
#  label: "Timeline Comparison Fields"

extension: required

dimension: getdate_func {
  hidden: yes
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
  sql: {% if exclude_days._parameter_value == "999" %}
           date((select max(${event_date}) from ${table_name}))
       {% else %}
           ${getdate_func}
       {% endif %};;
  # convert_tz: no
  }

  dimension: period_1_start {
    view_label: "Timeline Comparison Fields"
    description: "Calculates the start of the current period"
    type: date_raw
    # hidden:  yes
    # exclude_days value 999 = get last date that has data.
    sql: {% if exclude_days._parameter_value == "999" %}
           dateadd(${time_freq_dim}, -{% parameter size_of_range %} + 1 , ${current_date})
       {% else %}
           dateadd(${time_freq_dim}, -{% parameter size_of_range %} + 1 - {% parameter exclude_days %}, ${current_date})
       {% endif %};;
  }

  dimension: period_1_end {
    view_label: "Timeline Comparison Fields"
    description: "Calculates the end of the current period"
    type: date_raw
    # hidden:  yes
    sql: {% if exclude_days._parameter_value != "0" and exclude_days._parameter_value != "999" %}
            dateadd(${time_freq_dim}, -{% parameter exclude_days %}, ${current_date})
         {% else %}
            ${current_date}
         {% endif %};;
  }

  dimension: period_2_start {
    view_label: "Timeline Comparison Fields"
    description: "Calculates the start of the previous period"
    type: date_raw
        # hidden:  yes
    sql:
    {% if compare_to._parameter_value == "yoy" %}

       -- Same period, last year
      {% if exclude_days._parameter_value == "999" %}
        dateadd('days', -({% parameter size_of_range %} + 365) + 1, ${current_date})
       {% else %}
        dateadd('days', -({% parameter size_of_range %} + 365) + 1 - {% parameter exclude_days %}, ${current_date})
      {% endif %}

    {% else %}

      -- Starts from period 1 end, then goes back for doulbe the time
      {% if exclude_days._parameter_value == "999" %}
        dateadd(${time_freq_dim}, -({% parameter size_of_range %} * 2) + 1, ${current_date})
       {% else %}
        dateadd(${time_freq_dim}, -({% parameter size_of_range %} * 2) + 1 - {% parameter exclude_days %}, ${current_date})
      {% endif %}

    {% endif %};;

  }

  dimension: period_2_end {
    view_label: "Timeline Comparison Fields"
    description: "Calculates the end of the previous period"
    type: date_raw
    hidden:  yes
    sql:

      {% if compare_to._parameter_value == "yoy" %}
         {% if exclude_days._parameter_value == "999" %}
             dateadd('days', -365 , ${current_date})
         {% else %}
             dateadd('days', -365 - {% parameter exclude_days %}, ${current_date})
         {% endif %}

      {% else %}

          -- This block is the same as period 1 start, but with one extra day subtracted
         {% if exclude_days._parameter_value == "999" %}
             dateadd(${time_freq_dim}, -{% parameter size_of_range %}, ${current_date})
         {% else %}
             dateadd(${time_freq_dim}, -{% parameter size_of_range %} - {% parameter exclude_days %}, ${current_date})
         {% endif %}

      {% endif %}
      ;;

  }


  # dimension: period_2_start {
  #   view_label: "Timeline Comparison Fields"
  #   description: "Calculates the start of the previous period"
  #   type: date_raw
  #   sql: dateadd(${time_freq_dim}, -{% parameter size_of_range %}, ${period_1_start}) ;;
  #   hidden:  yes
  # }

  # dimension: period_2_end {
  #   view_label: "Timeline Comparison Fields"
  #   description: "Calculates the end of the previous period"
  #   type: date_raw
  #   sql: dateadd(${time_freq_dim}, -1, ${period_1_start}) ;;
  #   hidden:  yes
  # }

  dimension: period_3_start {
    view_label: "Timeline Comparison Fields"
    description: "Calculates the start of 2 periods ago"
    type: date_raw
    sql: dateadd(${time_freq_dim}, -(2*{% parameter size_of_range %}), ${period_1_start}) ;;
    hidden: yes

  }

  dimension: period_3_end {
    view_label: "Timeline Comparison Fields"
    description: "Calculates the end of 2 periods ago"
    type: date_raw
    sql: dateadd(${time_freq_dim}, -1, ${period_2_start}) ;;
    hidden: yes
  }

  dimension: period_4_start {
    view_label: "Timeline Comparison Fields"
    description: "Calculates the start of 4 periods ago"
    type: date_raw
    sql: dateadd(${time_freq_dim}, -(3*{% parameter size_of_range %}), ${period_1_start}) ;;
    hidden: yes
  }

  dimension: period_4_end {
    view_label: "Timeline Comparison Fields"
    description: "Calculates the end of 4 periods ago"
    type: date_raw
    sql: dateadd(${time_freq_dim}, -1, ${period_2_start}) ;;
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
    type: unquoted
    allowed_value: {
      label: "Trailing"
      value: "default"
    }
    allowed_value: {
      label: "This Period Last Year"
      value: "yoy"
    }
  }

  parameter: comparison_periods {
    label: "5. Number of Periods"
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
    allowed_value: {
      label: "4"
      value: "4"
    }
    default_value: "2"
  }

  parameter: time_freq {
    label: "4. Time Freq"
    view_label: "Timeline Comparison Fields"
    type: unquoted
    allowed_value: {
      label: "day"
      value: "day"
    }
    default_value: "day"
  }

  dimension: time_freq_dim {
    hidden: yes
    sql:  {% parameter time_freq %} ;;
    type: string
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
    description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period', 'Previous Period' or '3 Periods Ago'"
    type: string
    order_by_field: order_for_period
    sql:   case
             when ${event_date} between ${period_1_start} and ${period_1_end}
             then 'This Period'
             when ${event_date} between ${period_2_start} and ${period_2_end}
             then 'Last Period'
             {% if comparison_periods._parameter_value == "3" or comparison_periods._parameter_value == "4" %}
             when ${event_date} between ${period_3_start} and ${period_3_end}
             then '3 Periods Ago'
             {% endif %}
             {% if comparison_periods._parameter_value == "4" %}
             when ${event_date} between ${period_4_start} and ${period_4_end}
             then '4 Periods Ago'
             {% endif %}
           end ;;
  }

  dimension: order_for_period {
    hidden: yes
    view_label: "Timeline Comparison Fields"
    label: "Period"
    description: "Pivot me! Returns the period the metric covers, i.e. either the 'This Period', 'Previous Period' or '3 Periods Ago'"
    type: string
    sql:   case
             when ${event_date} between ${period_1_start} and ${period_1_end} then 1
             when ${event_date} between ${period_2_start} and ${period_2_end}
             then 2
             {% if comparison_periods._parameter_value == "3" or comparison_periods._parameter_value == "4" %}
             when ${event_date} between ${period_3_start} and ${period_3_end}
             then 3
             {% endif %}
             {% if comparison_periods._parameter_value == "4" %}
             when ${event_date} between ${period_4_start} and ${period_4_end}
             then 4
             {% endif %}
           end ;;
  }

  dimension: date_in_period {
    description: "Use this as your date dimension when comparing periods. Aligns the all previous periods onto the current period"
    label: "Date in Period"
    type: date
    sql: dateadd(${time_freq_dim}, ${day_in_period}, ${period_1_start}) ;;
    view_label: "Timeline Comparison Fields"
    convert_tz: no
  }


  dimension: day_in_period {
    view_label: "Timeline Comparison Fields"
    description: "Gives the number of days since the start of each periods. Use this to align the event dates onto the same axis, the axes will read 1,2,3, etc."
    type: number
    sql:case
          when ${event_date} between ${period_1_start} and ${period_1_end}
          then datediff(${time_freq_dim}, ${period_1_start}, ${event_date})
          when ${event_date} between ${period_2_start} and ${period_2_end}
          then datediff(${time_freq_dim}, ${period_2_start}, ${event_date})
          {% if comparison_periods._parameter_value == "3" or comparison_periods._parameter_value == "4" %}
          when ${event_date} between ${period_3_start} and ${period_3_end}
          then datediff(${time_freq_dim}, ${period_3_start}, ${event_date})
          {% endif %}
          {% if comparison_periods._parameter_value == "4" %}
          when ${event_date} between ${period_4_start} and ${period_4_end}
          then datediff(${time_freq_dim}, ${period_4_start}, ${event_date})
          {% endif %}
        end ;;
    hidden: no
  }
}
