module ActiveScaffold::Actions
  module Edit(T)
    macro included
      def edit
        config = active_scaffold_config.edit
        record = {{T}}.find(params["id"]).not_nil!
        label  = config.label(record)
        render("edit.slang")
      end
    end
  end
end