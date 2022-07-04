project_name: "looker_period_control"

constant: block_field_name {
  value: "Z - Period Control"
  export: override_optional
}

constant: date_display_format {
  # Set the date format for the period display (controled by the Display Dates in Period Labels" filter."
  value: "YYYY-MM-DD"
  export: override_optional
}
