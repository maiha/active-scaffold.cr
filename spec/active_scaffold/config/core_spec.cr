require "./spec_helper"

describe ActiveScaffold::Config::Core do
  describe "#label" do
    it "returns a model name in default" do
      config = UserController.active_scaffold_config.clone
      config.label.should eq("User")
    end
  end

  describe "#label=" do
    it "sets label" do
      config = UserController.active_scaffold_config.clone
      config.label = "user page"

      config.label.should eq("user page")
    end
  end

  describe "#columns" do
    it "returns content columns in default" do
      config = UserController.active_scaffold_config.clone
      config.columns.names.should eq(["first_name", "last_name"])
    end
  end

  describe "#columns=" do
    it "sets columns" do
      config = UserController.active_scaffold_config.clone
      config.columns = ["last_name"]

      config.columns.names.should eq(["last_name"])
    end

    it "overwrites previous values" do
      config = UserController.active_scaffold_config.clone
      config.columns = ["last_name"]
      config.columns = ["id", "first_name"]

      config.columns.names.should eq(["id", "first_name"])
    end
  end

  describe "#actions" do
    it "is mutable" do
      config = UserController.active_scaffold_config.clone
      config.actions = ["create", "update", "show"]
      config.actions.del "create"
      config.actions.add "delete"

      config.actions.names.should eq ["update", "show", "delete"]
    end
  end

  describe "#list" do
    it "builds a new config for List(T)" do
      config = UserController.active_scaffold_config.clone
      config.list.should be_a(ActiveScaffold::Config::List(User))
    end

    it "inherits column values lazily when first access" do
      config = UserController.active_scaffold_config.clone
      config.columns = ["first_name"]

      config.list.columns.names.should eq(["first_name"])
    end

    it "doesn't inherit values anymore after it is accessed" do
      config = UserController.active_scaffold_config.clone
      config.columns = ["first_name"]
      config.list.columns
      config.columns = ["id"]

      config.list.columns.names.should eq(["first_name"])
    end
  end
end
