module ActiveScaffold::Helpers
  module EditHelper
    def edit_record_value(config : Config::Base, column : Data::Column, record)
      id    = record_id(config, record)
      name  = "record[%s]" % column.name
      value = record_value?(config, column, record).to_s
      eid   = "record_%s_%s" % [column.name, URI.escape(id.to_s)]

      case value
      when /\n/
        css = "#{column.css_class} text-area"
        text_area(name: name, content: value, class: css, id: eid, cols: 60, rows: 3)
      else
        css = "#{column.css_class} text-input"
        text_field(name: name, value: value, class: css, id: eid)
      end
    end
  end

  include EditHelper
end
