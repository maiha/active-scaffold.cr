module ActiveScaffold
  module Config
    class List(T)
      include Base(T)

      DEFAULT_ACTION_LINKS = %w( show edit )

      var per_page : Int32 = 15
      var sorting  : String
      
      def setup!
        {% begin %}
        self.sorting = {{T}}.primary_name
        {% end %}
        self.action_links.set(DEFAULT_ACTION_LINKS)
      end
    end
  end
end
