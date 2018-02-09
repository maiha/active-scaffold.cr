module ActiveScaffold
  module Config
    class List(T)
      var columns  : Data::Columns(T)
      var per_page : Int32 = 15
      var sorting  : String
      
      def initialize(@core : Core(T))
        self.columns = Data::LazyColumns(T).new(@core.columns)
        {% begin %}
        self.sorting = {{T}}.primary_name
        {% end %}
      end
      
      def columns=(names : Array(String))
        columns.set(names)
      end
    end
  end
end
