module ActiveScaffold
  module Data
    module NamedAcl(T)
      include Enumerable(T)
      delegate each, to: current

      def_clone

      property positive : Set(String) = Set(String).new
      property negative : Set(String) = Set(String).new

      def clear
        self.positive = Set(String).new
        self.negative = Set(String).new
      end

      def set(names : Enumerable(String))
        self.positive = Set(String).new
        positive.concat(names)
      end

      def set(name : String)
        set([name])
      end

      def add(names : Array(String))
        positive.concat(names)
      end

      def add(name : String)
        add([name])
      end

      def del(names : Array(String))
        self.positive = Set(String).new(@hash.keys) if positive.empty?
        positive.subtract(names)
      end

      def del(name : String)
        del([name])
      end

      # returns an element for the given name if exists
      # otherwise returns nil
      def []?(name : String) : T?
        @hash[name]?
      end
      
      # returns an element for the given name if exists
      # otherwise build it
      def [](name : String) : T
        @hash[name] ||= T.new(name)
      end
      
      def current : Array(T)
        if positive.any?
          # respect order
          names = positive.clone
        else
          names = @hash.keys
        end

        return (names - negative.to_a).map{|name|
          self[name]
        }
      end

      def names : Array(String)
        current.map(&.name)
      end

      def to_s(io : IO)
        io << current.map(&.to_s).inspect
      end

      def inspect(io : IO)
        to_s(io)
        if positive.any?
          io << "(positive: %s)" % positive.to_a.inspect
        elsif negative.any?
          io << "(negative: %s)" % negative.to_a.inspect
        end
      end
    end
  end
end
