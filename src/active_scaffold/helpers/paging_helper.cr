module ActiveScaffold::Helpers
  module PagingHelper
    def paging_url(page) : String
      "/%s?page=%d" % [controller_name, page.number]
    end

    def paging_link(config, page)
      link_to page.number, "/", class: "as_paginate"
    end

    def paging_ajax_link(config, page)
      link_to page.number, "/", class: "as_paginate"
    end

    def paging_url_options(url_options = nil)
      if url_options.nil?
        url_options = {action: @paging_action || :index}
        # :id needed because rails reuse it even if it was deleted from params (like do_refresh_list does)
        url_options[:id] = nil if @remove_id_from_list_links
        url_options = params_for(url_options)
      end
      url_options
    end
  end

  include PagingHelper
end
