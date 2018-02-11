h1= label

div.table-responsive
  table.table.table-striped
    - columns.each do |column|
      tr
        th
          = column.name
        td
          = column.read(record)
    tr
      td colspan="2"
        - links.each do |link|
          span
            == link.render(record, self)
