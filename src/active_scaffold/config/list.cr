module ActiveScaffold
  module Config
    class List(T)
      include Base(T)

      DEFAULT_ACTION_LINKS = %w( show edit )

      property paging : Data::Paging = Data::Paging.new
      
      def setup!
        self.paging = Data::Paging.new(order: {{T}}.primary_name, limit: 15)
        self.action_links.set(DEFAULT_ACTION_LINKS)
      end
    end
  end
end
