module ActiveScaffold
  module Data
    class Paging
      def_equals_and_hash type, order, limit, count, index, window
      def_clone

      enum Type; FINITE; INFINITE; DISABLED; end
                              
      property type   : Type
      property order  : String
      property limit  : Int32
      property count  : Int32
      property index  : Int32
      property window : Int32

      def initialize(type = nil, order = nil, limit = nil, count = nil, index = nil, window = nil)
        @type   = type   || Type::FINITE
        @order  = order  || "id"
        @limit  = limit  || 15
        @count  = count  || 0
        @index  = index  || 0
        @window = window || 5
      end

      def sql : String
        limit  = [@limit, 0].max
        "ORDER BY %s LIMIT %d OFFSET %d" % [@order, limit, offset]
      end

      def number : Int32
        index + 1
      end

      def number=(v) : Int32
        @index = v - 1
      end

      def count=(v : Bool)
        if v
          @type = Type::FINITE
        else
          @type = Type::INFINITE
        end
      end

      def offset
        [@limit * @index, 0].max
      end

      def enabled? : Bool
        !type.disabled?
      end

      def page(page_no : Int32) : Paging
        clone.tap{|p| p.number = page_no}
      end

      def first : Paging
        page(1)
      end

      # Returns the number of last page when `type.finite?`.
      # Otherwise, it returns nil.
      def last_number? : Int32?
        type.finite? ? (count.to_f / limit).ceil.to_i : nil
      end

      def last? : Paging?
        last_number?.try{|n| page(n)}
      end

      def prev? : Paging?
        @index > 0 ? page(number - 1) : nil
      end

      def next? : Paging?
        if max = last_number?
          return (number + 1 <= max) ? page(number + 1) : nil
        else
          return page(number + 1)
        end
      end

      # Returns window-sized pages with last boundary when `type.finite?`.
      # Otherwise, it returns window-sized pages.
      def pages
        n1 = [1, number - window/2].max
        n2 = [number + window/2, last_number? || number + window].min
        range = (n1..n2)
        raise "[BUG] pages: #{range.size} exceeds (#{window})" if range.size > window
        range.map{|i| page(i)}
      end

      def to_s(io : IO)
        io << "Paging("
        case type
        when .disabled?
          io << "disabled"
        when .finite?
          io << "page:#{number}, limit:#{limit}, order:'#{order}', count:#{count}"
        when .infinite?
          io << "page:#{number}, limit:#{limit}, order:'#{order}'"
        end
        io << ")"
      end
    end
  end
end
