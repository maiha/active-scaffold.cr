td class="actions"
  table cellpadding="0" cellspacing="0"
    tr
      td class="indicator-container"
        - # loading_indicator_tag(:action => :record, :id => record.id)
      - config.action_links.each do |link|
        - next if !link.type.member?
        td
          == show_action_link(config, link, record)
