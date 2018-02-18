dl
  - config.columns.each do |column|
    dt= column.label
    - if column.is_a? ActiveScaffold::Data::Column
      - css_class = "#{column.name}-view #{column.css_class}"
      dd class="#{css_class.strip}"
        - value = show_record_value(config, column, record)
        - case value
        - when /\n/
          pre== value
        - else
          = value
          == "&nbsp;"
