# A Period Over Period Block for Looker

## Features
This block allows for a number of period over period type comparisons, both at the tile level, and for a full dashboard.

### Comparison Options
* Trailing period over period. Example: Last 7 days vs the prior 7 days before that. You must set the
* Trailing 30, 90, 180, and 365 - A trailing period over period
* Month to Date (MTD) vs prior month.
* MTD vs prior quarter.
* MTD vs prior year.
* Quarter to Date (QTD) vs prior quarter.
* QTD vs Prior Year.
* Year to Date (YTD) vs prior year.
* Last completed month vs the month before. For example, if we are in the middle of May, this would compare April to March.
* Last completed quarter vs the quarter before.
* Last completed year vs the year before.

### Start Date Options
* Exclude the current day. Useful when data is pulled nightly or you don't want to show an incomplete day.
* Exclude yesterday. Moves the start date back two days.
* Exclude to last data. This will automatically find the max date where data exists and start the comparison there.
* Exclude to end of prior week.
* Exclude to end of prior month.
* Exclude to end of prior quarter.
* Exclude to end of prior year.


## Usage

To use the PoP block, you must first import the project. Adding the following code to your manifest file will import the current master branch.

    remote_dependency: pop_block {
        url: "https://github.com/Cold-Bore-Capital/looker_pop_block"
        ref: "master"
     }

within the view the project must be imported

    include: "//pop_block/pop_block.view"

Several special fields must be set within the view. This is example is from a PDT. A few items are specific

    #----------- START POP BLOCK -----------
    extends: [pop_block, completed_time_block_filter]

    # The event date must be set to whatever main time series dimension_group is in use by the view.
    # It's very important to set convert_tz to no if you have only a date with no time value.
    dimension: event_date {
      sql: ${TABLE}.completed_date ;;
      type: date
      hidden: yes
      # Turn this to no if your table is pulling just a date. Yes if table is pulling a datetime type.
      convert_tz: no
    }

    # This field can be set to simply ${TABLE}. The table_name field is used
    dimension: table_name {
      type: string
      sql: ${TABLE} ;;
      hidden: yes
    }

    dimension: origin_event_date {
      sql: completeddate ;;
      type: string
      hidden: no
    }
    dimension: origin_table_name {
      type: string
      sql: ps.transactions;;
      hidden: no
    }
    #------------ END POP BLOCK ------------
