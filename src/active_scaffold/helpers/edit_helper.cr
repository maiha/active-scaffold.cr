module ActiveScaffold::Helpers
  module EditHelper
    def edit_record_value(config : Config::Base, column : Data::Column, record)
      id    = record.persisted? ? record_id(config, record) : "new"
      name  = "record[%s]" % column.name
      value = record_value?(config, column, record).to_s
      eid   = "record_%s_%s" % [column.name, URI.escape(id.to_s)]
      css   = column.css_class

      case value
      when /\n/
        css = "#{css} text-area"
        text_area(name: name, content: value, class: css, id: eid, cols: 60, rows: 3)
      else
        css = "#{css} text-input"
        text_field(name: name, value: value, class: css, id: eid)
      end
    end
  end

  include EditHelper
end
