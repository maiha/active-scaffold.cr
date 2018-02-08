module ActiveScaffold
  module Config
    class Core(T)
      var label   : String
      var list    : List(T)
      var system_columns : Data::Columns(T)
      var columns : Data::Columns(T)

      def initialize
        self.system_columns = Data::FixedColumns.new(build_columns)
        self.columns = Data::LazyColumns(T).new(system_columns)
        self.columns.filter = Set.new(Data::Column(T).contents.map(&.name))
        self.list = List(T).new(self)
      end

      def reset!
        initialize
      end

      def ignore_columns
        columns.ignore
      end
      
      def columns=(names : Array(String))
        columns.set(names)
      end

      private def build_columns : Array(Data::Column(T))
        orm_columns = %w( save destroy params to_h )
        Data::Column(T).all.reject{|c| orm_columns.includes?(c.name)}
      end
    end
  end
end
