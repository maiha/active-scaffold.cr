module ActiveScaffold
  module Config
    # Define `Base` as `module` rather than `class` due to Crystal BUG
    module Base(T)
      var parent  : Base(T)
      var id    : String
      var label : String
      
      @actions : Data::Actions(T)?
      @columns : Data::Columns(T)?
      @action_links : Data::ActionLinks(T)?

      def initialize(parent : Base(T)? = nil)
        {% begin %}
        self.id    = parent.try(&.id) || {{T}}.primary_name
        self.label = parent.try(&.label) || {{T}}.name
        {% end %}
        self.parent = parent.not_nil! if parent
        setup!
      end

      def dup
        dup = self.class.new(self)
        dup.id    = id
        dup.label = label
        dup.actions             # instantiate lazy object
        dup.columns             # instantiate lazy object
        dup
      end
      
      def reset!
        initialize
      end

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

      def action_links : Data::ActionLinks(T)
        (@action_links ||= build_action_links).not_nil!
      end
      
      def action_links=(names : Array(String))
        action_links.set(names)
      end

      private def setup!
      end

      private def build_actions : Data::Actions(T)
        if base = parent?
          base.actions.dup
        else
          Data::Actions(T).default
        end
      end

      private def build_action_links : Data::ActionLinks(T)
        if base = parent?
          links = base.action_links.dup
        else
          links = Data::ActionLinks(T).default
          links.each do |link|
            link.id = id
          end
        end
        if links.whites.empty? && actions.whites.any?
          links.set(actions.whites)
        end
        return links
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
