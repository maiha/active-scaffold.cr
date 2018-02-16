module ActiveScaffold::Actions
  module Show(T)
    macro included
      def show
        id     = params["id"]? || raise "params[id] not found"
        config = active_scaffold_config.show
        record = {{T}}.find(id) || raise "Couldn't find " + {{T.name.stringify}} + " (#{id})"
        label  = config.label(record)

        if params["adapter"]?
          render("_show.slang", "../../../lib/active_scaffold/src/active_scaffold/views/layout.slang")
        else
          render("show.slang")
        end
      end
    end
  end
end
