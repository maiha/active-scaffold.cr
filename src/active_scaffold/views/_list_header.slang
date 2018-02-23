- if action_links = config.action_links.collection
  - unless action_links.empty?
    div class="actions"
      - action_links.each do |link|
        == show_action_link(config, link)
      - #   <%= loading_indicator_tag(:action => :table) %>
h2= config.label
