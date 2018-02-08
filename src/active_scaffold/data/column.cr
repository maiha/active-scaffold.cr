require "./column_type"

module ActiveScaffold
  module Data
    class Column(T)
      getter name

      def initialize(@name : String)
      end

      def read(r : T)
        {% for m in T.methods %}
          {% if m.visibility == :public && m.args.size == 0 && !m.splat_index && !m.double_splat && !m.block_arg && m.name.stringify =~ /[^!?=]$/ %}
            return r.{{m.name.id}} if @name == {{m.name.stringify}}
          {% end %}
        {% end %}
        return nil
      end

      def self.all : Array(Column(T))
        cols = Array(Column(T)).new
        {% for m in T.methods %}
          {% if m.visibility == :public && m.args.size == 0 && !m.splat_index && !m.double_splat && !m.block_arg && m.name.stringify =~ /[^!?=]$/ %}
            cols << Column(T).new("{{m.name}}")
          {% end %}
        {% end %}
        return cols
      end

      def self.contents : Array(Column(T))
        cols = Array(Column(T)).new
        {% for name, type in T::FIELDS %}
          cols << Column(T).new("{{name}}")
        {% end %}
        return cols
      end
    end
  end
end
