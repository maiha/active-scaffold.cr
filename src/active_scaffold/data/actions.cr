module ActiveScaffold
  module Data
    class Actions(T)
      include Enumerable(String)
      delegate each, to: names

      var names : Set(String)

      def initialize(names : Array(String))
        set(names)
      end

      def dup
        dup = super()
        dup.names = names.dup
        dup
      end

      def set(names : Array(String))
        self.names = Set(String).new.concat(names)
      end

      def add(names : Array(String))
        self.names.concat(names)
      end

      def add(name : String)
        self.names.add(name)
      end

      def del(name : String)
        self.names.delete(name)
      end

      def del(names : Array(String))
        self.names.delete(names)
      end

      def del(name : String)
        self.names.delete(name)
      end
    end
  end
end
