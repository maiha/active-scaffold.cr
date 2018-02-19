div class="active-scaffold-footer"
  - if paging.type.finite?
    div class="active-scaffold-found"
      - count = paging.count
      - first = [paging.offset + 1, count].min
      - last  = [first + paging.limit - 1, count].min
      span
        - # 31 - 60 of 188 in total
        == "<b>%d</b> - <b>%d</b> of <b>%d</b> in total" % [first, last, count]

  - if !paging.type.disabled?
    div class="active-scaffold-pagination"
      == render(partial: "_list_paging_links.slang")
    br
