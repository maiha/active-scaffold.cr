module ActiveScaffold
  module Data
    class ActionLink(T)
      def_clone

      getter name

      enum MethodType; GET; POST; PUT; end
      enum Type      ; COLLECTION; MEMBER; end
      
      property url    : String
      property label  : String
      property type   : Type = Type::COLLECTION
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
        @type = Type::COLLECTION
      end

      def show!
        @url = "/:controller/:id"
        @type = Type::MEMBER
      end

      def edit!
        @url = "/:controller/:id/edit"
        @type = Type::MEMBER
      end

      def new!
        @url = "/:controller/new"
        @type = Type::COLLECTION
      end
    end
  end
end
