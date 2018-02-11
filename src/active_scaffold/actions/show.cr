module ActiveScaffold::Actions
  module Show(T)
    macro included
      def show
        config  = active_scaffold_config.show
        columns = config.columns
        record  = {{T}}.find(params["id"]).not_nil!
        links   = config.action_links
        label   = config.label(record)
        render("show.slang")
      end
    end
  end
end
