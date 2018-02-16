module ActiveScaffold::Helpers
  module LocalizeHelper
    def as_(key, options = nil)
      key.to_s
    end
  end

  include LocalizeHelper
end
