div class="active-scaffold"
  div class="show-view #{controller_name}-view view"
    h4= label
    == render partial: "_show_columns.slang"

    p class="form-footer"
      == link_to as_(:close), main_path_to_return, class: "as_cancel", remote: xhr?
      - # loading_indicator_tag(:action => :create, :id => params[:id])
