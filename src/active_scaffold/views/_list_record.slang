- # tr_class = cycle("", "even-record") + ' ' + list_row_class(record)
- tr_class = even ? "even-record" : ""
- # url_options = params_for(:action => :list, :id => record.id)
- # action_links ||= active_scaffold_config.action_links.member

- id = element_row_id({"action" => "list", "id" => record_id(config, record)})
- # url_for(params_for(:action => :row, :id => record.id, :_method => :get))
- data_refresh = ""

tr id="#{id}" data-refresh="#{data_refresh}" class="record #{tr_class}"
  == render(partial: "_list_record_columns.slang")
  == render(partial: "_list_actions.slang")
  - # = render_nested_view(action_links, url_options, record) unless @nested_auto_open.nil?
