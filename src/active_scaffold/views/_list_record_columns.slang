- config.columns.each do |column|
  - # TODO: authorized = record.authorized_for?(:crud_type => :read, :column => column.name) -%>
  - authorized = true
  - # column_value = authorized ? get_column_value(config, column, record) : config.empty_field_text
  td
    = show_list_column(config, column, record)
