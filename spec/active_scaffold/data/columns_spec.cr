require "./spec_helper"

private def user_columns
  default = ActiveScaffold::Config::Default(User).new
  ActiveScaffold::Config::Core(User).new(default).columns
end

describe ActiveScaffold::Data::Columns do
  it "has content columns in default" do
    columns = user_columns
    columns.names.should eq ["first_name", "last_name"]
  end
end
