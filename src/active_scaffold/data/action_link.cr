module ActiveScaffold
  module Data
    class ActionLink(T)
      def_clone

      getter name

      enum MethodType; DELETE; GET; POST; PUT; end
      enum Type      ; COLLECTION; MEMBER; end
      
      property url    : String
      property label  : String
      property type   : Type = Type::COLLECTION
      property method : MethodType = MethodType::GET
      property css    : String
      property attrs  : Hash(String, String) = Hash(String, String).new

      def initialize(@name : String, label : String? = nil, @url = "/", @css = "")
        @label = label || @name.capitalize
      end

      def onclick : String
        attrs["onclick"]?.to_s
      end

      def to_s(io : IO)
        io << name
      end

      def inspect(io : IO)
        io << "#{name} (#{url})"
      end

      ######################################################################
      ### state change
      def delete!
        @method = MethodType::DELETE
        @url    = "/:controller/:id?_method=delete&_csrf=:csrf_token"
        @type   = Type::MEMBER
        @attrs["onclick"] = "return confirm('Are you sure?');"
      end

      def edit!
        @method = MethodType::GET
        @url    = "/:controller/:id/edit"
        @type   = Type::MEMBER
      end

      def list!
        @method = MethodType::GET
        @url    = "/:controller"
        @type   = Type::COLLECTION
      end

      def new!
        @method = MethodType::GET
        @url    = "/:controller/new"
        @type   = Type::COLLECTION
      end

      def show!
        @method = MethodType::GET
        @url    = "/:controller/:id"
        @type   = Type::MEMBER
      end
    end
  end
end
