module ActiveScaffold
  module Config
    # Define `Base` as `module` rather than `class` due to Crystal BUG
    module Base(T)
      @base    : Base(T)

      @id      : String?
      @label   : String?
      @actions : Data::Actions(T)?
      @columns : Data::Columns(T)?
      @action_links : Data::ActionLinks(T)?

      @debug   : Bool?

      PROPERTY_NAMES = %w( id label actions columns action_links debug )
      
      def initialize(@base : Base(T))
        setup!
      end

      def clone
        self.class.new(self)
      end

      {% for m in PROPERTY_NAMES %}
        def {{m.id}}
          (@{{m.id}} ||= build_{{m.id}}).not_nil!
        end

        def {{m.id}}=(v)
          @{{m.id}} = v
        end

        private def build_{{m.id}}
          @base.{{m.id}}.clone
        end
      {% end %}

      def label(record : T)
        if label.includes?("%s")
          return label % Pretty.method(record).call?(id)
        else
          return label
        end
      end
      
      def ignore_columns
        columns.ignore
      end

      def actions=(names : Array(String))
        actions.set(names)
      end

      def columns=(names : Array(String))
        columns.set(names)
      end

      def action_links=(names : Array(String))
        action_links.set(names)
      end

      private def setup!
      end
    end
  end
end
