module ActiveScaffold
  module Config
    class Show(T)
      include Base(T)

      def link
        link = Data::ActionLink(T).new("show", label: "show", type: "member")
        # :security_method => :show_authorized?, :ignore_method => :show_ignore?
        link.url = "/:controller/:id"
        return link
      end
    end
  end
end
