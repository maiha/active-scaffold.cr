- # sorting = active_scaffold_config.list.user.sorting
- # sorting_stages = ['reset', 'ASC', 'DESC']
- # default_sorting = active_scaffold_config.list.user.default_sorting
- # default_sorting_stages = ['ASC', 'DESC']
- config.columns.each do |column|
  - # stages = default_sorting.sorts_on?(column) ? default_sorting_stages : sorting_stages
  - #  render_column_heading(column, sorting, stages.after(sorting.direction_of(column)) || 'ASC')
  th
    a href="#" = column.label
th class="actions"
