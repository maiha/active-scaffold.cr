div class="active-scaffold-footer"
  div class="active-scaffold-found"
    - if paging.type.finite?
      - count = paging.count
      - first = [paging.offset + 1, count].min
      - last  = [first + paging.limit - 1, count].min
      span
        - # 31 - 60 of 188 in total
        == "<b>%d</b> - <b>%d</b> of <b>%s</b> in total" % [first, last, count]
    - else
      - first = paging.offset + 1
      - last  = first + paging.limit - 1
      span
        == "<b>%d</b> - <b>%d</b>" % [first, last]

  - if !paging.type.disabled?
    div class="active-scaffold-pagination"
      == render(partial: "_list_paging_links.slang")
    br
