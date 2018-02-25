module ActiveScaffold::Actions
  module Delete(T)
    macro included
      def delete
        destroy
      end

      def destroy
        record = {{T}}.find(params["id"])
        config = active_scaffold_config.delete
        label  = config.label(record)

        record.destroy
        redirect_to resolve_url("/:controller")
      end
    end
  end
end
