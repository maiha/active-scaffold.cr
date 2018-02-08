require "./columns"

module ActiveScaffold
  module Data
    class FixedColumns(T)
      include Columns(T)

      getter columns
      
      def initialize(@columns : Array(Column(T)))
      end
    end
  end
end
