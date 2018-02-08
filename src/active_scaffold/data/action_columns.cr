require "./action_column"

module ActiveScaffold(T)
  module Data
    class ActionColumns
      include Enumerable(ActionColumn)

      var columns : Array(ActionColumn) = Array(ActionColumn).new
      delegate each, to: columns
    
      def add(name : String, type : String)
        columns << ActionColumn.new(name, ActionColumnType.parse(type))
      end
    end
  end
end
