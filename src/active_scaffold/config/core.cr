module ActiveScaffold
  module Config
    class Core(T)
      include Base(T)

      CHILD_CONFIG_NAMES = %w( new create list show edit update )
      
      # @list : List(T)?
      # def list
      #   @list ||= List(T).new(self)
      # end
      {% for m in CHILD_CONFIG_NAMES %}
        @{{m.id}} : {{m.capitalize.id}}(T)?
        def {{m.id}}
          (@{{m.id}} ||= {{m.capitalize.id}}(T).new(self)).not_nil!
        end

        def {{m.id}}=(v)
          @{{m.id}} = v
        end
      {% end %}

      def clone
        clone = super()
        # NOTE: inherits only modified fields
        # clone.list = list if @list
        {% for m in CHILD_CONFIG_NAMES %}
          clone.{{m.id}} = {{m.id}}.clone if @{{m.id}}
        {% end %}
        clone
      end
      
      def to_h
        hash = Hash(String, Base(T)).new
        hash["core"] = self
        {% for m in CHILD_CONFIG_NAMES %}
          hash[{{m}}] = {{m.id}}
        {% end %}
        return hash
      end
    end
  end
end
