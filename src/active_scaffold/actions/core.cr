module ActiveScaffold::Actions
  module Core(T)
    macro included
      def new
        raise "{{@type.name}}#new is not implemented yet."
      end

      def create
        raise "{{@type.name}}#create is not implemented yet."
      end

      def destroy
        raise "{{@type.name}}#destroy is not implemented yet."
      end
    end
  end
end
