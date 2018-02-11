module ActiveScaffold
  module Data
    class Action(T)
      getter name

      def initialize(@name : String)
      end
    end
  end
end
