require "./named_acl"
require "./action"

module ActiveScaffold
  module Data
    class Actions(T)
      include NamedAcl(Action(T))

      def initialize(@hash : Hash(String, Action(T)))
      end

      def self.default
        hash = Hash(String, Action(T)).new
        %w( list create show update delete search nested subform ).each do |name|
          hash[name] = Data::Action(T).new(name)
        end
        return new(hash)
      end
    end
  end
end
