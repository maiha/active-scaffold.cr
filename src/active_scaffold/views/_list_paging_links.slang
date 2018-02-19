- if paging.enabled?
  - first = paging.first
  - pages = paging.pages

  - if paging.number > 1
    == link_to as_("First"), paging_url(first), class: "as_paginate previous"

  - if page = paging.prev?
    == link_to as_("Previous"), paging_url(page), class: "as_paginate previous"

  - if pages.first.number != first.number
    span.as_paginate= "..."

  - pages.each do |page|
    - if page.number == paging.number
      span.as_paginate= paging.number
    - else
      == link_to page.number.to_s, paging_url(page), class: "as_paginate"

  - if (paging.last? == nil) || paging.last?.try{|p| p.number != pages.last.number}
    span.as_paginate= "..."

  - if page = paging.next?
    == link_to as_("Next"), paging_url(page), class: "as_paginate next"

  - if last = paging.last?
    == link_to as_("Last"), paging_url(last), class: "as_paginate next"
  - else
    span.as_paginate= as_("Last")
