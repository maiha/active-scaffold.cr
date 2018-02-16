require "./spec_helper"

describe "Usercase(inherit)" do
  describe "#id" do
    it "affects list" do
      config = UserController.active_scaffold_config.dup
      config.id = "foo"
      config.list.id.should eq "foo"
    end
  end

  describe "#columns" do
    it "can be overriden by child" do
      config = UserController.active_scaffold_config.dup
      config.columns = ["foo"]
      config.show.columns.add "bar"

      config.columns.names.should eq ["foo"]
      config.show.columns.names.should eq ["foo", "bar"]
    end
  end

  describe "#dup" do
    it "inherits original instance" do
      config = UserController.active_scaffold_config.dup
      config.columns = ["foo"]
      config.show.columns.add "bar"

      dup = config.dup
      dup.columns.names.should eq ["foo"]
      dup.show.columns.names.should eq ["foo", "bar"]
    end
  end
end
