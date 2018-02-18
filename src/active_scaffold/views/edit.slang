h1= label

== render partial: "_active_scaffold_config.slang"

- action = "/%s/%s" % [controller_name, record_id(config, record)]
- method = record.persisted? ? :patch : :post
== form(action: action, method: method) do
  == csrf_tag
  == render partial: "_edit.slang"
