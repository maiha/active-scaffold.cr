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
        setup_system!
        setup!
      end

      private def setup_system!
        self.actions.positive = Set(String).new(default(ACTIONS_ADD)) if default(ACTIONS_ADD).any?
        self.actions.negative = Set(String).new(default(ACTIONS_DEL)) if default(ACTIONS_DEL).any?
        self.actions = default(ACTIONS) if default(ACTIONS).any?

        self.action_links.positive = Set(String).new(default(ACTION_LINKS_ADD)) if default(ACTION_LINKS_ADD).any?
        self.action_links.negative = Set(String).new(default(ACTION_LINKS_DEL)) if default(ACTION_LINKS_DEL).any?
        self.action_links = default(ACTION_LINKS) if default(ACTION_LINKS).any?

        self.columns.positive = Set(String).new(default(COLUMNS_ADD)) if default(COLUMNS_ADD).any?
        self.columns.negative = Set(String).new(default(COLUMNS_DEL)) if default(COLUMNS_DEL).any?
        self.columns = default(COLUMNS) if default(COLUMNS).any?
      end

      protected def setup!
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

      ######################################################################
      ### Helpers
      def content_columns : Array(Data::Column(T))
        columns.content(self)
      end

      ######################################################################
      ### default values
      private macro default(key)
        Default::{{@type.class.name.gsub(/^.*::/, "").gsub(/\(.*$/, "").capitalize}}::{{key.stringify.upcase.id}}
      end
    end
  end
end
