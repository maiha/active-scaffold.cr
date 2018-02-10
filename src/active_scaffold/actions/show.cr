module ActiveScaffold::Actions
  module Show(T)
    macro included
      def show
        config  = active_scaffold_config.show
        columns = config.columns
        record  = {{T}}.find(params["id"]).not_nil!
        render("show.slang")
      end
    end
  end
end
