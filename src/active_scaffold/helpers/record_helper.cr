module ActiveScaffold::Helpers
  module RecordHelper
    def record_id(config : Config::Base, record)
      Pretty.method(record).call(config.id)
    end

    def record_value?(config : Config::Base, column : Data::Column, record)
      if column.type.method?
        name = column.name
        Pretty.method(record).call?(name)
      else
        nil
      end
    end
  end

  include RecordHelper
end
