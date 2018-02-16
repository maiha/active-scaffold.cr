module ActiveScaffold
  module Config
    class Default(T)
      include Base(T)

      def initialize
        @base = self
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
        %w( list create show update delete search nested subform ).each do |name|
          hash[name] = Data::Action(T).new(name)
        end
        Data::Actions(T).new(hash).tap &.set(%w( list show edit ))
      end

      private def build_action_links : Data::ActionLinks(T)
        hash = Hash(String, Data::ActionLink(T)).new { |h, k|
          h[k] = Data::ActionLink(T).new(k)
        }
        # %w( list create show update delete search nested subform )
        hash["list"].list!
        hash["show"].show!
        hash["edit"].edit!
        links = Data::ActionLinks(T).new(hash)
        if links.whites.empty? && actions.whites.any?
          links.set(actions.whites)
        end
        return links
      end

      private def build_columns : Data::Columns(T)
        Data::Columns(T).content_columns
      end
    end
  end
end
