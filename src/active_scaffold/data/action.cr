module ActiveScaffold
  module Data
    class Action(T)
      def_clone

      getter name

      def initialize(@name : String)
      end

      def to_s(io : IO)
        io << name
      end
    end
  end
end
