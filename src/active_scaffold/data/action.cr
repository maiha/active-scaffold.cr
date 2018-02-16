module ActiveScaffold
  module Data
    class Action(T)
      getter name

      def initialize(@name : String)
      end

      def to_s(io : IO)
        io << name
      end
    end
  end
end
