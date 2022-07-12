project_name: "looker_period_control"

constant: block_field_name {
  value: "Z - Period Control"
  export: override_optional
}

constant: date_display_format {
  # Set the date format for the period display (controled by the Display Dates in Period Labels" filter."
  value: "YYYY-MM-DD"   # YYYY-MM-DD HH24:MI
  export: override_optional
}

constant: days_in_standard_month {
  # Set the number of days in a month. This is used when "Normalize Range Size" is turned off and prior month is selected. This has the effect of
  # calculating the prior month as date_add('days', -@{days_in_standard_month}, the_date_value).
  value: "30"
  export: override_optional
}

constant: days_in_standard_quarter {
  # Set the number of days in a quarter. This is used when "Normalize Range Size" is turned off and prior quarter is selected. This has the effect of
  # calculating the prior quarter as date_add('days', -@{days_in_standard_quarter}, the_date_value).
  value: "91"
  export: override_optional
}
