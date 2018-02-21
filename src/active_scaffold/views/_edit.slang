div.table-responsive
  table.table.table-striped
    - config.columns.each do |column|
      tr
        th
          = column.label
        td
          == edit_record_value(config, column, record)
    tr
      td colspan="2" style="text-align: center;"
        == submit(config.action_links["update"].label, class: "btn btn-success btn-xs")
    tr
      td colspan="2"
        - config.action_links.each do |link|
          span
            == show_action_link(config, link, record, class: "btn btn-primary btn-xs")
