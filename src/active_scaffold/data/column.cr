module ActiveScaffold
  module Data
    class Column(T)
      def_clone

      getter name

      enum Type; FIELD; METHOD; VIRTUAL; end

      property label    : String?
      property type     : Type = Type::VIRTUAL
      property truncate : Int32 = 50
      property css      : String
      property attrs    : Hash(String, String) = Hash(String, String).new

      def initialize(@name : String, @label = nil, method = false, @css = "")
        @type  = Type::METHOD if method
        @type  = Type::FIELD  if T.new.to_h.keys.includes?(@name)
      end

      def label
        @label || @name.split("_").map(&.capitalize).join(" ")
      end

      def to_s(io : IO)
        io << name
      end
    end
  end
end
