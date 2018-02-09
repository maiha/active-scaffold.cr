require "./columns"

module ActiveScaffold
  module Data
    class LazyColumns(T)
      include Columns(T)

      def initialize(@all : Columns(T))
      end

      def dup
        dup = self.class.new(@all.dup)
        dup.filter = filter.dup
        dup.ignore = ignore.dup
        dup
      end
      
      def build_columns : Array(Column(T))
        array = @all.columns.dup
        if filter.any?
          array.select!{|c| filter.includes?(c.name)}
        elsif ignore.any?
          array.reject!{|c| ignore.includes?(c.name)}
        end
        return array
      end

      def columns : Array(Column(T))
        return build_columns
      end

      protected def before_update
      end
    end
  end
end
