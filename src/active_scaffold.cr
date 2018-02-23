require "amber"
require "granite_orm"
require "var"
require "pretty"

module ActiveScaffold(T)
end

require "./active_scaffold/data/*"
require "./active_scaffold/configure"
require "./active_scaffold/actions/*"
require "./active_scaffold/helpers/*"

module ActiveScaffold(T)
  macro included
    include ActiveScaffold::Configure(T)
    include ActiveScaffold::Actions::Core(T)
    include ActiveScaffold::Actions::New(T)
    include ActiveScaffold::Actions::Create(T)
    include ActiveScaffold::Actions::List(T)
    include ActiveScaffold::Actions::Show(T)
    include ActiveScaffold::Actions::Edit(T)
    include ActiveScaffold::Actions::Update(T)
    include ActiveScaffold::Helpers
  end
end
