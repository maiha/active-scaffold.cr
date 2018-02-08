module ActiveScaffold::Actions
  module List(T)
    macro included
      def index
        count = {{T}}.count
        columns = active_scaffold_config.list.columns
        records = {{T}}.all("limit 3")
        render("index.slang")
      end
    end
  end
end
