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

        label = "%s" % [{{T.name.stringify}}]

        
        if validator.valid?
          record.set_attributes(validator.params)
          record.save
        end

        if validator.valid? && record.valid?
          flash["success"] = as_("Created %s successfully.") % [label]
          redirect_to "/%s" % controller_name
        else
          validator.errors.each do |e|
            # TODO: This depends on inner class of Granite::ORM
            record.errors << Granite::ORM::Error.new(e.param, e.message)
          end
          flash["danger"] = as_("Could not create %s.") % [label]
          new(record)
        end
      end
    end
  end
end
