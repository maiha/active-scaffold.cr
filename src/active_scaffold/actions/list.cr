module ActiveScaffold::Actions
  module List(T)
    macro included
      def index
        if params["id"]? && !params["id"].is_a?(Array) && xhr?
          do_row(params["id"])
        elsif action_name =~ /^(index|list)$/
          do_list
        else
#          do_refresh_list
          do_list
        end
      end
      
      protected def do_list
        config  = active_scaffold_config.list
        count   = {{T}}.count
        records = {{T}}.all("limit #{config.per_page}")
#        respond_to_action(:list)
        render("list.slang")
      end
      
      protected def do_row(id)
        config  = active_scaffold_config.list
        record  = {{T}}.find(id).not_nil!
        # render("index.slang")
        return "Not implemented yet"
      end
    end
  end
end
