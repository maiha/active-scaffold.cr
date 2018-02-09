require "./config/*"

module ActiveScaffold
  module Configure(T)
    macro included
      def self.active_scaffold_config : ActiveScaffold::Config::Core(T)
        @@active_scaffold_config ||= ActiveScaffold::Config::Core(T).new
      end

      def self.active_scaffold(&block)
        yield(active_scaffold_config)
      end

      @active_scaffold_config : ActiveScaffold::Config::Core(T)?
      def active_scaffold_config
        (@active_scaffold_config ||= self.class.active_scaffold_config.dup).not_nil!
      end

      def active_scaffold(&block)
        yield(active_scaffold_config)
      end
    end
  end
end
