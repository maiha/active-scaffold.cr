module ActiveScaffold::Actions
  module New(T)
    macro included
      # args are passed from `create`
      def new(record = nil)
        record ||= {{T}}.new

        config = active_scaffold_config.new
        label  = config.label(record)
        render("new.slang")
      end
    end
  end
end
