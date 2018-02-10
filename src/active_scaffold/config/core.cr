module ActiveScaffold
  module Config
    class Core(T)
      include Base(T)

      var list : List(T)
      var show : Show(T)

      def setup!
        self.list = List(T).new(self)
        self.show = Show(T).new(self)
      end

      def dup
        dup = super()
        dup.list = list.dup
        dup.show = show.dup
        dup
      end
    end
  end
end
