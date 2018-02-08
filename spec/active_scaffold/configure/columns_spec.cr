require "./spec_helper"

describe ActiveScaffold::Config::Core do
  describe "#columns" do
    it "returns content columns in default" do
      config.columns.map(&.name).should eq(["first_name", "last_name"])
    end
  end

  describe "#columns=" do
    it "sets columns" do
      config.columns = ["last_name"]
      config.columns.map(&.name).should eq(["last_name"])
    end
  end
end
