module ActiveScaffold
  module Data
    class Column(T)
      getter name

      enum Type; FIELD; METHOD; VIRTUAL; end

      property label     : String
      property type      : Type = Type::VIRTUAL
      property css_class : String = ""
      property truncate  : Int32 = 50

      def initialize(@name : String, label : String? = nil, method = false)
        @label = label || @name
        @type  = Type::METHOD if method
        @type  = Type::FIELD  if T.new.to_h.keys.includes?(@name)
      end

      def to_s(io : IO)
        io << name
      end
    end
  end
end
