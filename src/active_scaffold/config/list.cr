module ActiveScaffold
  module Config
    class List(T)
      include Base(T)

      property paging : Data::Paging = Data::Paging.new
      
      protected def setup!
        self.paging = Data::Paging.new
        {% if v = Default::List.constant("PAGING") %}
          self.paging = Data::Paging.new(**{{v}})
        {% end %}
        self.paging.order = {{T}}.primary_name
      end

      def clone
        clone = super()
        clone.paging = paging.clone
        clone.action_links = action_links.clone
        clone
      end
    end
  end
end
