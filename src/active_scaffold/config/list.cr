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
    end
  end
end
