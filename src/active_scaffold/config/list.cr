module ActiveScaffold
  module Config
    class List(T)
      include Base(T)

      var per_page : Int32 = 15
      var sorting  : String
      
      def setup!
        {% begin %}
        self.sorting = {{T}}.primary_name
        {% end %}
      end

      def link
        link = Data::ActionLink(T).new("list", label: "list", type: "members")
        link.url = "/:controller"
        return link
      end
    end
  end
end
