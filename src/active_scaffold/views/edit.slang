h1= label

div.table-responsive
  table.table.table-striped
    - config.columns.each do |column|
      tr
        th
          = column.label
        td
          = show_column_value(config, column, record)
    tr
      td colspan="2"
        - config.action_links.each do |link|
          span
            == show_action_link(config, link, record)
