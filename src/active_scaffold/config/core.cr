module ActiveScaffold
  module Config
    class Core(T)
      include Base(T)

      CHILD_CONFIG_NAMES = %w( list show edit )
      
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

      def dup
        dup = super()
        # NOTE: inherits only modified fields
        # dup.list = list if @list
        {% for m in CHILD_CONFIG_NAMES %}
          dup.{{m.id}} = {{m.id}} if @{{m.id}}
        {% end %}
        dup
      end
      
      def to_h
        {
          "core" => self,
          "list" => list,
          "show" => show,
        }
      end
    end
  end
end
