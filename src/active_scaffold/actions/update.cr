module ActiveScaffold::Actions
  module Update(T)
    macro included
      def update
        config = active_scaffold_config.update
        id     = params["id"]
        record = {{T}}.find(id)
        label  = config.label(record)

        do_update(config, id, record)
      end
      
      protected def do_update(config, id, record)
        # copy `record[foo]` to `foo`
        params.each do |key, val|
          params[$1] = val if key =~ /^record\[(.*?)\]$/
        end

        validator = params.validation do
          Data::Columns(T).content_keys.each do |k|
            required(k) { |f| !f.nil? }
          end
        end
        record.set_attributes(validator.validate!)

        label = "%s(%s)" % [{{T.name.stringify}}, id]
        if record.valid? && record.save
          flash["success"] = as_("Updated %s successfully.") % [label]
          redirect_to "/%s" % controller_name
        else
          flash["danger"] = as_("Could not update %s.") % [label]
          edit
        end
      end
    end
  end
end
