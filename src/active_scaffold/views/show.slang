h1= label

== render partial: "_active_scaffold_config.slang"

div.table-responsive
  table.table.table-striped
    - config.columns.each do |column|
      tr
        th
          = column.label
        td
          - value = show_record_value(config, column, record)
          - case value
          - when /\n/
            pre== value
          - else
            = value
            == "&nbsp;"
    tr
      td colspan="2"
        - config.action_links.each do |link|
          span
            == show_action_link(config, link, record, class: "btn btn-primary btn-xs")
