module ActiveScaffold::Helpers
  module RequestHelper
    def xhr?
      request.headers["HTTP_X_REQUESTED_WITH"]? == "XMLHttpRequest"
    end
  end

  include RequestHelper
end
