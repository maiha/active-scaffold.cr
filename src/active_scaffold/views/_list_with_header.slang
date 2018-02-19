div id=controller_id class="active-scaffold active-scaffold-as_#{controller_name} #{controller_name}-view default-theme"
  div class="active-scaffold-header"
    == render(partial: "_list_header.slang")
  div id="as_#{controller_name}-content" class="as_content"
    == render(partial: "_list.slang")
