module ActiveScaffold::Actions
  module Edit(T)
    macro included
      # args are passed from `update`
      def edit(record = nil)
        record ||= {{T}}.find(params["id"])

        config = active_scaffold_config.edit
        label  = config.label(record)
        render("edit.slang")
      end
    end
  end
end
