module ActiveScaffold::Helpers
  module RenderHelper
    macro render_system(template, layout = nil)
      render_template("lib/active_scaffold/src/active_scaffold/views/#{template}.slang")
#      render_template()
    end
  end

  include RenderHelper
end
