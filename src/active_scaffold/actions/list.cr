module ActiveScaffold::Actions
  module List(T)
    macro included
      def index
        count = {{T}}.count
        list  = active_scaffold_config.list
        actions = list.actions
        columns = list.columns
        records = {{T}}.all("limit #{list.per_page}")
        render("index.slang")
      end
    end
  end
end
