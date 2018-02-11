require "./named_acl"
require "./action_link"

module ActiveScaffold
  module Data
    class ActionLinks(T)
      include NamedAcl(ActionLink(T))

      def initialize(@hash : Hash(String, ActionLink(T)))
      end

      def self.default
        hash = Hash(String, ActionLink(T)).new { |h, k|
          h[k] = ActionLink(T).new(k)
        }
        # %w( list create show update delete search nested subform )
        hash["list"] = Config::List(T).new.link
        hash["show"] = Config::Show(T).new.link
        return new(hash)
      end
    end
  end
end
