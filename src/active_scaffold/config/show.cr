module ActiveScaffold
  module Config
    class Show(T)
      include Base(T)

      DEFAULT_ACTION_LINKS = %w( list edit )

      def setup!
        self.action_links.set(DEFAULT_ACTION_LINKS)
      end
    end
  end
end
