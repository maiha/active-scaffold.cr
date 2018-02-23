module ActiveScaffold::Actions
  module Create(T)
    macro included
      def create
        config = active_scaffold_config.create
        record = {{T}}.new
        label  = config.label(record)

        do_create(config, record)
      end
      
      protected def do_create(config, record)
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

        label = "%s" % [{{T.name.stringify}}]
        if record.valid? && record.save
          flash["success"] = as_("Created %s successfully.") % [label]
          redirect_to "/%s" % controller_name
        else
          flash["danger"] = as_("Could not create %s.") % [label]
          new(record)
        end
      end
    end
  end
end
