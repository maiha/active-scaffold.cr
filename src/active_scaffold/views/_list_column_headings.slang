- list_url = resolve_url(config.action_links["list"].url)
- ary = paging.order.split(/\s+/)
- order = ary.shift? || config.id
- asc   = !((ary.shift? || "") == "desc")

- config.columns.each do |column|
  - # stages = default_sorting.sorts_on?(column) ? default_sorting_stages : sorting_stages
  - #  render_column_heading(column, sorting, stages.after(sorting.direction_of(column)) || 'ASC')
  th
    - asc = (order == column.name) ? !asc : true
    - url = "%s?order=%s&asc=%s&page=%d" % [list_url, column.name, asc, paging.number]
    - url = "#" if !column.type.field?
    a href=url = column.label
th class="actions"
