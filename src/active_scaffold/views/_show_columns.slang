dl
  - config.columns.each do |column|
    dt= column.label
    - if column.is_a? ActiveScaffold::Data::Column
      - css = "#{column.name}-view #{column.css}".strip
      dd class=css
        - value = show_record_value(config, column, record)
        - case value
        - when /\n/
          pre== value
        - else
          = value
          == "&nbsp;"
