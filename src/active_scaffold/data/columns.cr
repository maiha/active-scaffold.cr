require "./column"

module ActiveScaffold
  module Data
    class Columns(T)
      include Enumerable(Column(T))
      delegate each, to: columns

      property filter = Set(String).new
      property ignore = Set(String).new

      def initialize(@all : Array(Column(T)))
      end
      
      def dup
        dup = self.class.new(@all.dup)
        dup.filter = filter.dup
        dup.ignore = ignore.dup
        dup
      end
      
      def columns : Array(Column(T))
        return build_columns
      end

      def set(names : Array(String))
        filter.clear
        add(names)
      end

      def set(name : String)
        set([name])
      end

      def add(names : Array(String))
        filter.concat(names)
      end

      def add(name : String)
        add([name])
      end

      def del(names : Array(String))
        filter.subtract(names)
      end

      def del(name : String)
        del([name])
      end

      private def build_columns : Array(Column(T))
        array = @all.dup
        if filter.any?
          array.select!{|c| filter.includes?(c.name)}
        elsif ignore.any?
          array.reject!{|c| ignore.includes?(c.name)}
        end
        return array
      end

      # collect all public methods except
      # - argments exist
      # - bang and equal methods
      # - methods of ORM features
      def self.all : Columns(T)
        cols = Array(Column(T)).new
        {% for m in T.methods %}
          {% if m.visibility == :public && m.args.size == 0 && !m.splat_index && !m.double_splat && !m.block_arg && m.name.stringify =~ /[^!=]$/ %}
            {% if !%w( save destroy params to_h valid? ).includes?(m.name) %}
              cols << Column(T).new("{{m.name}}")
            {% end %}
          {% end %}
        {% end %}
        return Columns(T).new(cols)
      end

      def self.from_model : Columns(T)
        columns = all
        columns.filter.concat({{T::FIELDS.keys.map(&.stringify)}})
        return columns
      end

      def to_s(io : IO)
        io << build_columns.map(&.name).inspect
      end

      def inspect(io : IO)
        io << build_columns.map(&.name).inspect
        if filter.any?
          io << "(filter: %s)" % filter.to_a.inspect
        elsif ignore.any?
          io << "(ignore: %s)" % ignore.to_a.inspect
        end
      end
    end
  end
end
