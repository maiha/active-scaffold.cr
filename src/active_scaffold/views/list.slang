== render partial: "_active_scaffold_config.slang"

div id=controller_id class="active-scaffold active-scaffold-as_#{controller_name} #{controller_name}-view default-theme"
  div class="active-scaffold-header"
    div class="actions"
    - # a class="new as_action" data-position="top" data-action="new" id="as_users-new--link" data-remote="true" href="/users/new">Create New</a><a class="show_search as_action" data-position="top" data-action="show_search" id="as_users-show_search--link" data-remote="true" href="/users/show_search">Search<
    - # <img style="visibility:hidden;" id="as_users-table--loading-indicator" alt="loading indicator" class="loading-indicator" src="/assets/active_scaffold/indicator-07b20xxxxx.gif">
    h2= config.label
    == render(partial: "_list.slang")
