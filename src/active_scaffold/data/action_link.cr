module ActiveScaffold
  module Data
    class ActionLink(T)
      getter name

      enum MethodType
        GET
        POST
        PUT
      end
      
      property url    : String
      property label  : String
      property method : MethodType = MethodType::GET
      property css_class : String

      def initialize(@name : String, label : String? = nil, @url = "/", @css_class = "")
        @label = label || @name.capitalize
      end

      def to_s(io : IO)
        io << name
      end

      def inspect(io : IO)
        io << "#{name} (#{url})"
      end

      ######################################################################
      ### state change
      def list!
        @url = "/:controller"
      end

      def show!
        @url = "/:controller/:id"
      end

      def edit!
        @url = "/:controller/:id/edit"
      end
    end
  end
end
