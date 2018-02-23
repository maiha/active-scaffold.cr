require "./named_acl"
require "./action_link"

module ActiveScaffold
  module Data
    class ActionLinks(T)
      include NamedAcl(ActionLink(T))

      def_clone

      def initialize(@hash : Hash(String, ActionLink(T)) = Hash(String, ActionLink(T)).new)
      end

      def collection : Array(ActionLink(T))
        self.select(&.type.collection?)
      end

      def member : Array(ActionLink(T))
        self.select(&.type.member?)
      end
    end
  end
end
