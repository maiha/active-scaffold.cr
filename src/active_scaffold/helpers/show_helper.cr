module ActiveScaffold::Helpers
  module ShowHelper
    def show_record_value(config : Config::Base, column : Data::Column, record)
      if column.type.virtual?
        "(virtual column not supported yet)"
      else
        name = column.name
        Pretty.method(record).call?(name) || "(no method: #{name})"
      end
    end

    def show_action_link(config : Config::Base , link : Data::ActionLink, record)
      id_builder = ->{ Pretty.method(record).call(config.id) }
      url = resolve_url(link.url, id_builder)
      link_to(link.label.to_s, url, class: link.css_class)
    end

    def show_list_column(config : Config::Base, column : Data::Column, record)
      text = show_record_value(config, column, record)
      Pretty.truncate(text, size: column.truncate)
    end
  end

  include ShowHelper
end
