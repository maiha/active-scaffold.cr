require "./spec_helper"

private def config
  UserController.active_scaffold_config
end

describe ActiveScaffold::Config::Core do
  describe "#label" do
    it "returns a model name in default" do
      config.label.should eq("User")
    end
  end

  describe "#label=" do
    it "sets label" do
      config.label = "user page"
      config.label.should eq("user page")
    end
  end

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

    it "overwrites previous values" do
      config.columns = ["last_name"]
      config.columns = ["id", "first_name"]
      config.columns.map(&.name).should eq(["id", "first_name"])
    end
  end

  describe "#list" do
    it "builds a new config for List(T)" do
      config.list.should be_a(ActiveScaffold::Config::List(User))
    end

    it "inherits column values" do
      config.columns = ["first_name"]
      config.list.columns.map(&.name).should eq(["first_name"])
    end

    it "doesn't share column values once overwrites it" do
      config.columns = ["first_name"]
      config.list.columns.map(&.name).should eq(["first_name"])

      config.list.columns = ["id"]
      config.columns = ["last_name"]

      config.list.columns = ["id"]
    end
  end
end
