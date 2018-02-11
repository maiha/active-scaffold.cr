require "./named_acl"
require "./column"

module ActiveScaffold
  module Data
    class Columns(T)
      include NamedAcl(Column(T))

      def initialize(@hash : Hash(String, Column(T)))
      end

      # collect all public methods except
      # - argments exist
      # - bang and equal methods
      # - methods of ORM features
      def self.all : Columns(T)
        hash = Hash(String, Column(T)).new
        {% for m in T.methods %}
          {% if m.visibility == :public && m.args.size == 0 && !m.splat_index && !m.double_splat && !m.block_arg && m.name.stringify =~ /[^!=]$/ %}
            {% if !%w( save destroy params to_h valid? ).includes?(m.name) %}
              hash["{{m.name}}"] = Column(T).new("{{m.name}}")
            {% end %}
          {% end %}
        {% end %}
        return Columns(T).new(hash)
      end

      def self.from_model : Columns(T)
        columns = all
        columns.set({{T::FIELDS.keys.map(&.stringify)}})
        return columns
      end
    end
  end
end
