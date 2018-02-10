module ActiveScaffold
  module Config
    # Define `Base` as `module` rather than `class` due to Crystal BUG
    module Base(T)
      var parent  : Base(T)
      var label   : String

      @actions : Data::Actions(T)?
      @columns : Data::Columns(T)?

      def initialize(parent : Base(T)? = nil)
        {% begin %}
        self.label  = {{T}}.name
        {% end %}
        self.parent = parent.not_nil! if parent
        setup!
      end

      def dup
        dup = self.class.new(self)
        dup.label = label
        dup.actions             # instantiate lazy object
        dup.columns             # instantiate lazy object
        dup
      end
      
      def reset!
        initialize
      end

      def ignore_columns
        columns.ignore
      end

      def actions : Data::Actions(T)
        (@actions ||= build_actions).not_nil!
      end
      
      def actions=(names : Array(String))
        actions.set(names)
      end

      def columns : Data::Columns(T)
        (@columns ||= build_columns).not_nil!
      end
      
      def columns=(names : Array(String))
        columns.set(names)
      end

      private def setup!
      end

      private def build_actions : Data::Actions(T)
        if base = parent?
          base.actions.dup
        else
          names = %w( create list search update delete show nested subform )
          Data::Actions(T).new(names)
        end
      end

      private def build_columns : Data::Columns(T)
        if base = parent?
          base.columns.dup
        else
          Data::Columns(T).from_model
        end
      end
    end
  end
end
