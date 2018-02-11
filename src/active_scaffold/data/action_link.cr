module ActiveScaffold
  module Data
    class ActionLink(T)
      getter name

      property id    : String
      property url   : String
      property label : String

      def initialize(@name : String, label : String? = nil, @type = "member", @id = "id", @url = "/")
        @label = label || @name
      end

      def render(r : T, ctx : Amber::Controller::Base) : String
        url = @url.gsub(/:id\b/, id(r)).gsub(/:controller\b/, ctx.controller_name)
        ctx.link_to(label.to_s, url, class: "btn btn-success btn-xs")
      end

      def id(r : T)
        Pretty.method(r).call(@id)
      end

      def to_s(io : IO)
        io << name
      end
    end
  end
end
