module ActiveScaffold::Helpers
  module RecordHelper
    def show_column_value(config : Config::Base, column : Data::Column, record)
      if column.type.method?
        name = column.name
        Pretty.method(record).call?(name) || "(no method: #{name})"
      else
        "(virtual column not supported yet)"
      end
    end

    def show_action_link(config : Config::Base , link : Data::ActionLink, record)
      id_builder = ->{ Pretty.method(record).call(config.id) }
      url = resolve_url(link.url, id_builder)
      link_to(link.label.to_s, url, class: link.css_class)
    end

    def show_list_column(config : Config::Base, column : Data::Column, record)
      text = show_column_value(config, column, record)
      Pretty.truncate(text, size: column.truncate)
    end
  end

  include RecordHelper
end
