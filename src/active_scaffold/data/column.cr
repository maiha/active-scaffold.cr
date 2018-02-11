require "./column_type"

module ActiveScaffold
  module Data
    class Column(T)
      getter name

      def initialize(@name : String)
      end

      def read(r : T)
        Pretty.method(r).call(@name)
      end

      def to_s(io : IO)
        io << name
      end
    end
  end
end
