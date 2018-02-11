div.row
  div.col-sm-10
    h2= active_scaffold_config.label
  div.col-sm-2
    div= Time.now.to_s("%Y-%m-%d %H:%M:%S")

div.row
  div.col-sm-12
    .count= count

div.table-responsive
  table.table.table-striped
    thead
      tr
        - columns.each do |column|
          th
            = column.name
        th
    tbody
      - records.each do |record|
        tr
          - columns.each do |column|
            td
              = column.read(record)
          - links.each do |link|
            td
              span
                == link.render(record, self)
