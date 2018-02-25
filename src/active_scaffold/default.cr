# an empty array stands for NOP: **inherit**
private macro inherit
  [] of String
end

module ActiveScaffold::Default
  # global
  module Global
    ACTIONS          = %w( new list show edit )
    ACTIONS_ADD      = [] of String
    ACTIONS_DEL      = [] of String

    ACTION_LINKS     = [] of String
    ACTION_LINKS_ADD = [] of String
    ACTION_LINKS_DEL = [] of String

    COLUMNS          = [] of String # automatically computed at compile time
    COLUMNS_ADD      = [] of String
    COLUMNS_DEL      = [] of String
  end

  # config
  module Core
    ACTIONS          = inherit
    ACTIONS_ADD      = inherit
    ACTIONS_DEL      = inherit

    ACTION_LINKS     = inherit
    ACTION_LINKS_ADD = inherit
    ACTION_LINKS_DEL = inherit

    COLUMNS          = inherit
    COLUMNS_ADD      = inherit
    COLUMNS_DEL      = inherit
  end

  # config.create
  module Create
    ACTIONS          = inherit
    ACTIONS_ADD      = inherit
    ACTIONS_DEL      = inherit

    ACTION_LINKS     = inherit
    ACTION_LINKS_ADD = inherit
    ACTION_LINKS_DEL = inherit

    COLUMNS          = inherit
    COLUMNS_ADD      = inherit
    COLUMNS_DEL      = inherit
  end

  # config.edit
  module Edit
    ACTIONS          = inherit
    ACTIONS_ADD      = inherit
    ACTIONS_DEL      = inherit

    ACTION_LINKS     = %w( list show )
    ACTION_LINKS_ADD = inherit
    ACTION_LINKS_DEL = inherit

    COLUMNS          = inherit
    COLUMNS_ADD      = inherit
    COLUMNS_DEL      = inherit
  end

  # config.list
  module List
    ACTIONS          = inherit
    ACTIONS_ADD      = inherit
    ACTIONS_DEL      = inherit

    ACTION_LINKS     = %w( new show edit )
    ACTION_LINKS_ADD = inherit
    ACTION_LINKS_DEL = inherit

    COLUMNS          = inherit
    COLUMNS_ADD      = inherit
    COLUMNS_DEL      = inherit

    # PAGING         = {limit: 15, window: 5}
  end

  # config.new
  module New
    ACTIONS          = inherit
    ACTIONS_ADD      = inherit
    ACTIONS_DEL      = inherit

    ACTION_LINKS     = %w( list )
    ACTION_LINKS_ADD = inherit
    ACTION_LINKS_DEL = inherit

    COLUMNS          = inherit
    COLUMNS_ADD      = inherit
    COLUMNS_DEL      = inherit
  end

  # config.show
  module Show
    ACTIONS          = inherit
    ACTIONS_ADD      = inherit
    ACTIONS_DEL      = inherit

    ACTION_LINKS     = %w( list show )
    ACTION_LINKS_ADD = inherit
    ACTION_LINKS_DEL = inherit

    COLUMNS          = inherit
    COLUMNS_ADD      = inherit
    COLUMNS_DEL      = inherit
  end

  # config.update
  module Update
    ACTIONS          = inherit
    ACTIONS_ADD      = inherit
    ACTIONS_DEL      = inherit

    ACTION_LINKS     = inherit
    ACTION_LINKS_ADD = inherit
    ACTION_LINKS_DEL = inherit

    COLUMNS          = inherit
    COLUMNS_ADD      = inherit
    COLUMNS_DEL      = inherit
  end
end
