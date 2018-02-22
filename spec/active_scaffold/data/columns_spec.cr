require "./spec_helper"

private def user_columns
  default = ActiveScaffold::Config::Default(User).new
  ActiveScaffold::Config::Core(User).new(default).columns
end

describe ActiveScaffold::Data::Columns do
  it "contains timestamp in default" do
    columns = ActiveScaffold::Data::Columns(User).content_columns
    columns.names.includes?("created_at").should be_true
    columns.names.includes?("updated_at").should be_true
  end
end
