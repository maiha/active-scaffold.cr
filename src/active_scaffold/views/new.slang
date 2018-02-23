== render(partial: "_record_errors.slang")

h1= label
== render partial: "_active_scaffold_config.slang"

- # TODO: use url in ActionLink
- action = "/%s" % [controller_name]
- method = record.persisted? ? :patch : :post
== form(action: action, method: method) do
  == csrf_tag
  == render partial: "_edit.slang"

  div.table-responsive
    table.table
      tr
        td style="text-align: center;"
          == submit(config.action_links["create"].label, class: "btn btn-success btn-xs")
      tr
        td
          - config.action_links.each do |link|
            span
              == show_action_link(config, link, record, class: "btn btn-primary btn-xs")
