require "./column_type"

module ActiveScaffold
  module Data
    class Column(T)
      getter name

      enum ColumnType
        METHOD
        VIRTUAL
      end
      
      property label : String
      property type : ColumnType = ColumnType::VIRTUAL
      property css_class : String = ""
      property truncate : Int32 = 50

      def initialize(@name : String, label : String? = nil, method = false)
        @label = label || @name
        @type  = ColumnType::METHOD if method
      end

      def to_s(io : IO)
        io << name
      end
    end
  end
end
