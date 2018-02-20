- if config.debug || params["debug"]?
  a href="#" onclick="$('#debug_active_scaffold_config').toggle();return false;" = "DEBUG: active_scaffold_config"
  #debug_active_scaffold_config style="display: none;"
    table.active-scaffold
      thead
        tr
          th== link_to "config", "#"
          th== link_to "id", "#"
          th== link_to "actions", "#"
          th== link_to "columns", "#"
          th== link_to "action_links", "#"
          th== link_to "(extra)", "#"
      tbody
        - i = 0
        - active_scaffold_config.to_h.each do |key, _conf|
          - i += 1
          - color = i.even? ? "even-record" : ""
          - style = (config == _conf) ? "background-color: pink;" : ""
          tr class="record #{color}" style=style
            td
              b= key
            td= _conf.id
            td= _conf.actions
            td= _conf.columns
            td== _conf.action_links.map(&.inspect).join("<br>")
            td
              - case _conf
              - when ActiveScaffold::Config::List
                = _conf.paging
