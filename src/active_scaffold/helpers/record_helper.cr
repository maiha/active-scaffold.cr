module ActiveScaffold::Helpers
  module RecordHelper
    def record_id(config : Config::Base, record)
      Pretty.method(record).call(config.id)
    end

    def record_value?(config : Config::Base, column : Data::Column, record)
      if column.type.virtual?
        nil
      else
        Pretty.method(record).call?(column.name)
      end
    end
  end

  include RecordHelper
end
