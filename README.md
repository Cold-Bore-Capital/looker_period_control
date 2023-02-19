# Looker Period Control Block
This is a Looker block that allows you to control the period of time that is being displayed in a dashboard along with period comparison. This block is designed to replace all other forms of date control on a dashboard giving users the option to filter regular tiles, and tiles with period comparison requirements all in a single control. 

Unlink many existing period over period blocks for Looker, the Looker Period Control block relies heavily on LookML. This shifts processing to Looker instead of the database, and allows the system to generate SQL that's easy to read and debug.

## Key Features
* Control the period of time for a dashboard or tile via a simple dropdown.
* Allow for easy period selection including:
    * Trailing days
    * Period selection of trailing X days, and pre-set ranges like current week, last month, etc.
    * Comparison to a trailing period, last full week, month, quarter, year, etc.
* Allow for comparison of up to 53 periods in a single chart.
* Easy integration and deployment.
* Generates readable SQL for easy debugging.
* Set an "As Of" date. This allows a user to pick a date other than today, while still selecting a value such as "trailing 90 days". 
* Easily filter the end date of a tile to:
  * Yesterday
  * Two Days Ago
  * End of Last Full Week, Month, Quarter, Year


## Installation
To use the Looker Period Control Block, you will need to add the external package to your manifest file, add a short bit of code to your model, then add several dimensions to your view along with an include.

### Manifest File
```yaml
remote_dependency: looker_period_control {
  url: "https://github.com/Cold-Bore-Capital/looker_period_control"
  # Find the latest tag hash here https://github.com/Cold-Bore-Capital/looker_period_control/tags
  ref: "a7a0b6807862e93ac3e75a1aaa10510b07ef156e" # Hash for tag V1.4.15
}
```




### Model Explore
Adding the looker_period_control block to your explore only takes a single line of code. Simply add `sql_always_where: ${sql_always_where_inject};;` to the explore block. This will allow the Looker Period Control block to inject the correct date filter into the explore.

```yaml
explore:  orders {
  sql_always_where: ${sql_always_where_inject};;
}
```

### View
At the top of the view file, place the following code to include the block. 

```yaml
include: "//looker_period_control/main.view"
```

Copy and paste the following template into the file, updating the fields as specified. Note, it is best practice to set `hidden: yes` on any date fields within the view, or simply don't include the `dimension_group` for dates in the file. This will help prevent your users from accidentally filtering on, or selecting the wrong date dimension in a tile. 

#### View Block Template
```yaml
#----------- Looker Period Control Block -----------
  extends: [main]


  dimension: event_date {
    sql: ${TABLE}.<replace_with_date_field>;;
    # Important. If this field only contains a date, with no time, this must be set to no. You will have major problems
    # if a date such as 2022-01-01 is converted to local time. Looker will think of this as 2022-01-01 00:00:00 and in the case
    # of a -5 conversion, would turn that into 2021-12-31 19:00:00.
    convert_tz: no
    
    # --- Do Not Edit Below this Line ----
    type: date_raw
    hidden: yes
    # --- End No Not Edit block       ----

  }

  parameter: convert_tz {
    # Instructions: If your date is just a date with no time, set this value to no. If your date is a date with time, set to yes. It is VERY important that you do
    # not set this value to yes if you only have a date. Bad things will happen.
    default_value: "yes"

    # --- Do Not Edit Below this Line ----
    type: yesno
    hidden: yes
    # --- End No Not Edit block       ----
  }
  
  # Do not edit table_name. This should stay as is.
  dimension: table_name {
    # --- Do Not Edit Below this Line ----
    type: string
    sql: ${TABLE} ;;
    hidden: yes
    # --- End No Not Edit block       ----
  }

  # Origin event date and origin period name are required when using the "Last Data" filter option. The value here will be
  # used to create a (select max(date_field) from table) type query. This will be used to limit the date range to the max date.
  # When using a derived table, the query has no way to know what table name to query for last data. If using a derived table,
  # these values should be set to whatever source table contains the "max" date. 
  
  dimension: origin_event_date {
    # Instructions: Replace with the name of the origin date column
    sql: <replace_with_date_field> ;;
    # --- Do Not Edit Below this Line ----
    type: string
    hidden: yes
    # --- End No Not Edit block       ----
  }
  
  dimension: origin_table_name {
    # Instructions: The origin_table_name dimension allows for the use of "Last Data" filter option. If you are 
    # using a PDT, you must hand enter the schema and table name of whatever table contains the date dimension. 
    # For example, if you had a PDT that mostly derived from shop.orders, you would enter that. If using a 
    # standard SQL table, you can enter the name of the view and SQL_TABLE_NAME. For example ${my_view.
    # SQL_TABLE_NAME}.
    sql: ${<replace_with_view_name>.SQL_TABLE_NAME} OR <replace with origin schema and table>;;
    # --- Do Not Edit Below this Line ----
    type: string
    hidden: yes
    # --- End No Not Edit block       ----
  }

  #------------ End Looker Period Control Block ------------
  ```

#### View Block Example 
```yaml
#----------- Looker Period Control Block -----------
  extends: [main]


  dimension: event_date {
    sql: ${TABLE}.order_date;;
    # Important. If this field only contains a date, with no time, this must be set to no. You will have major problems
    # if a date such as 2022-01-01 is converted to local time. Looker will think of this as 2022-01-01 00:00:00 and in the case
    # of a -5 conversion, would turn that into 2021-12-31 19:00:00.
    convert_tz: no
    
    # --- Do Not Edit Below this Line ----
    type: date_raw
    hidden: yes
    # --- End No Not Edit block       ----

  }

  parameter: convert_tz {
    # Instructions: If your date is just a date with no time, set this value to no. If your date is a date with time, set to yes. It is VERY important that you do
    # not set this value to yes if you only have a date. Bad things will happen.
    default_value: "yes"

    # --- Do Not Edit Below this Line ----
    type: yesno
    hidden: yes
    # --- End No Not Edit block       ----
  }
  
  # Do not edit table_name. This should stay as is.
  dimension: table_name {
    # --- Do Not Edit Below this Line ----
    type: string
    sql: ${TABLE} ;;
    hidden: yes
    # --- End No Not Edit block       ----
  }

  # Origin event date and origin period name are required when using the "Last Data" filter option. The value here will be
  # used to create a (select max(date_field) from table) type query. This will be used to limit the date range to the max date.
  # When using a derived table, the query has no way to know what table name to query for last data. If using a derived table,
  # these values should be set to whatever source table contains the "max" date. 
  
  dimension: origin_event_date {
    # Instructions: Replace with the name of the origin date column
    sql: order_date ;;
    # --- Do Not Edit Below this Line ----
    type: string
    hidden: yes
    # --- End No Not Edit block       ----
  }
  
  dimension: origin_table_name {
    # Instructions: The origin_table_name dimension allows for the use of "Last Data" filter option. If you are 
    # using a PDT, you must hand enter the schema and table name of whatever table contains the date dimension. 
    # For example, if you had a PDT that mostly derived from shop.orders, you would enter that. If using a 
    # standard SQL table, you can enter the name of the view and SQL_TABLE_NAME. For example ${my_view.
    # SQL_TABLE_NAME}.
    sql: ${my_view.SQL_TABLE_NAME};;
    # --- Do Not Edit Below this Line ----
    type: string
    hidden: yes
    # --- End No Not Edit block       ----
  }

  #------------ End Looker Period Control Block ------------
  ```

## Usage

### Filters

#### Tile Only Filters
Tile only filters are designed to be used within a single tile, not on a dashboard. 

##### Debug Mode (Yes / No)

Debug mode will place a block of SQL comment code into the rendered SQL with information about the current filter state. It should not be necassary unless you are activly developing for the period control block. The block will look like this

```sql
-- *****************************************
-- As of Value:       NULL
-- Period Selection:  trailing
-- Exclude Value:     999
-- Snap Start Date:   none
-- Compare to Period: prior_month
-- Range Size:        2
-- Additional Days:   0
-- Range Start:       2
-- Range End:         0
-- Convert TZ:        true
-- *****************************************
```

##### Display Dates in Period Labels 
This filter turns on date display in your axis labels. 