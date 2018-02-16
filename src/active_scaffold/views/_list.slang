table cellpadding="0" cellspacing="0"
  thead
    tr
      == render(partial: "_list_column_headings.slang")
    - # == render(partial: "list_messages")
  tbody class="records" id=active_scaffold_tbody_id
    - if !records.empty?
      - # == render(partial: "list_record"', :collection => @page.items, :locals => { :hidden => false, :columns => columns, :action_links => active_scaffold_config.action_links.member} %>
      - records.each_with_index do |record, i|
        - even = i.even?
        == render(partial: "_list_record.slang")
    - # if columns.any? {|c| c.calculation?} -%>
    - # render :partial => 'list_calculations', :locals => {:columns => columns}

- # render :partial => 'list_pagination'
