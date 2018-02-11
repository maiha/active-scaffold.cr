require "amber"
require "granite_orm"
require "var"

module ActiveScaffold(T)
end

require "./active_scaffold/data/*"
require "./active_scaffold/configure"
require "./active_scaffold/actions/*"

module ActiveScaffold(T)
  macro included
    include ActiveScaffold::Configure(T)
    include ActiveScaffold::Actions::List(T)
    include ActiveScaffold::Actions::Show(T)
  end
end
