module ActiveScaffold::Actions
  module List(T)
    macro included
      def index
        list
      end

      def list
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
        paging  = build_paging(config)
        records = find_records(paging)
#        respond_to_action(:list)
        render("list.slang")
      end
      
      protected def do_row(id)
        config  = active_scaffold_config.list
        record  = {{T}}.find(id).not_nil!
        # render("index.slang")
        return "Not implemented yet"
      end

      protected def find_records(paging : Data::Paging)
        {{T}}.all(paging.sql)
      end

      protected def build_paging(config : Config::List(T))
        paging = config.paging
        if order = params["order"]?
          asc = (params["asc"]?.to_s == "false") ? "ASC" : "DESC"
          paging.order = "%s %s" % [order, asc] 
        end
        paging.number = [(params["page"]? || 1).to_i, 1].max
        paging.count  = paging.type.finite? ? {{T}}.count : -1
        return paging
      end
    end
  end
end
