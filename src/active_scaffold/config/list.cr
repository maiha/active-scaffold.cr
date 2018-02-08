module ActiveScaffold
  module Config
    class List(T)
      var columns : Data::Columns(T)

      def initialize(@core : Core(T))
        self.columns = Data::LazyColumns(T).new(@core.columns)
      end
      
      def columns=(names : Array(String))
        columns.set(names)
      end
    end
  end
end
