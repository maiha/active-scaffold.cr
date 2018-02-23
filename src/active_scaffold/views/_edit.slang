div.table-responsive
  table.table.table-striped
    - config.content_columns.each do |column|
      - error = record.errors.any?(&.field.to_s.== column.name)
      - css = "active-scaffold-error" if error

      tr class=css
        th
          = column.label
        td
          == edit_record_value(config, column, record)
