require "./named_acl"
require "./action"

module ActiveScaffold
  module Data
    class Actions(T)
      include NamedAcl(Action(T))

      def_clone

      def initialize(@hash : Hash(String, Action(T)))
      end
    end
  end
end
