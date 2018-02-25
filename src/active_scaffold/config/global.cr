module ActiveScaffold
  module Config
    class Global(T)
      include Base(T)

      def initialize
        @base = self
        setup_system!
      end

      private def build_debug
        false
      end

      private def build_id
        {{T}}.primary_name
      end

      private def build_label
        {{T}}.name
      end

      private def build_actions : Data::Actions(T)
        hash = Hash(String, Data::Action(T)).new
        Data::Actions(T).new(hash)
      end

      private def build_action_links : Data::ActionLinks(T)
        hash = Hash(String, Data::ActionLink(T)).new { |h, k|
          h[k] = Data::ActionLink(T).new(k)
        }
        # %w( list new show update delete search nested subform )
        hash["list"].list!
        hash["show"].show!
        hash["edit"].edit!
        hash["new"].new!
        links = Data::ActionLinks(T).new(hash)
        if links.positive.empty? && actions.positive.any?
          links.set(actions.positive)
        end
        return links
      end

      private def build_columns : Data::Columns(T)
        Data::Columns(T).content_columns
      end
    end
  end
end
