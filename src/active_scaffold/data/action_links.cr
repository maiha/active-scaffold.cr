require "./named_acl"
require "./action_link"

module ActiveScaffold
  module Data
    class ActionLinks(T)
      include NamedAcl(ActionLink(T))

      def initialize(@hash : Hash(String, ActionLink(T)))
      end
    end
  end
end
