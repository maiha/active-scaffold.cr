module ActiveScaffold
  module Config
    class New(T)
      include Base(T)

      DEFAULT_ACTION_LINKS = %w( list )

      def setup!
        self.action_links.set(DEFAULT_ACTION_LINKS)
      end
    end
  end
end
