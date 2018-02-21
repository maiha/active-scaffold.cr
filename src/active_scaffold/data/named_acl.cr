module ActiveScaffold
  module Data
    module NamedAcl(T)
      include Enumerable(T)
      delegate each, to: current

      def_clone

      property whites = Set(String).new
      property blacks = Set(String).new

      def clear
        self.whites = Set(String).new
        self.blacks = Set(String).new
      end

      def set(names : Enumerable(String))
        self.whites = Set(String).new
        whites.concat(names)
      end

      def set(name : String)
        set([name])
      end

      def add(names : Array(String))
        whites.concat(names)
      end

      def add(name : String)
        add([name])
      end

      def del(names : Array(String))
        self.whites = Set(String).new(@hash.keys) if whites.empty?
        whites.subtract(names)
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
        if whites.any?
          # respect order
          names = whites.clone
        else
          names = @hash.keys
        end

        return (names - blacks.to_a).map{|name|
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
        if whites.any?
          io << "(whites: %s)" % whites.to_a.inspect
        elsif blacks.any?
          io << "(blacks: %s)" % blacks.to_a.inspect
        end
      end
    end
  end
end
