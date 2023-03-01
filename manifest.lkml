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

constant: time_display_format {
  value: "HH:MI"
  export: override_optional
}

constant: days_in_standard_month {
  # Set the number of days in a month. This is used for error checking, and may be used in a future version for a "normalize range size" function.
  value: "30"
  export: override_optional
}

constant: days_in_standard_quarter {
  # Set the number of days in a quarter. This is used for error checking, and may be used in a future version for a "normalize range size" function.
  value: "91"
  export: override_optional
}

constant: database_time_zone {
  # Set this to the value of the timezone in your database.
  value: "UTC"
  export: override_optional
}

constant: database_type {
  # Options:
  # 1. redshift
  # 2. big_query
  # 3. snowflake
  value: "redshift"
  # value: "big_query"
  # value: "snowflake"
}
