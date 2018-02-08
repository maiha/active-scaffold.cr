require "./column"

module ActiveScaffold
  module Data
    module Columns(T)
      include Enumerable(Column(T))
      delegate each, to: columns

      property filter = Set(String).new
      property ignore = Set(String).new

      abstract def columns : Array(Column(T))

      def set(names : Array(String))
        filter.clear
        add(names)
      end

      def add(names : Array(String))
        filter.concat(names)
      end

      def del(names : Array(String))
        ignore.concat(names)
      end
    end
  end
end
