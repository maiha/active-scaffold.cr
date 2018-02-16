module ActiveScaffold
  module Config
    class Edit(T)
      include Base(T)

      DEFAULT_ACTION_LINKS = %w( list show )

      def setup!
        self.action_links.set(DEFAULT_ACTION_LINKS)
      end
    end
  end
end
