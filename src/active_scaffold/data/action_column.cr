require "./action_column_type"

module ActiveScaffold(T)
  module Data
    record ActionColumn, name : String, type : ActionColumnType
  end
end
