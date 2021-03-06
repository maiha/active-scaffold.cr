require "./spec_helper"

describe "cases for inherit" do
  describe "#id" do
    it "affects list" do
      config = UserController.active_scaffold_config.clone
      config.id = "foo"
      config.list.id.should eq "foo"
    end
  end

  describe "#columns" do
    it "can be overriden by child" do
      config = UserController.active_scaffold_config.clone
      config.columns = ["foo"]
      config.show.columns.add "bar"

      config.columns.names.should eq ["foo"]
      config.show.columns.names.should eq ["foo", "bar"]
    end
  end

  describe "#clone" do
    it "inherits paging" do
      config = UserController.active_scaffold_config.clone
      config.list.paging.order = "foo"
      config.list.paging.limit = 7

      config.clone.list.paging.should eq config.list.paging
    end

    it "inherits columns" do
      config = UserController.active_scaffold_config.clone
      config.columns = ["foo"]
      config.show.columns.add "bar"

      clone = config.clone
      clone.columns.names.should eq ["foo"]
      clone.show.columns.names.should eq ["foo", "bar"]
    end

    it "inhertis action_links" do
      config = UserController.active_scaffold_config.clone
      config.list.action_links = ["new"]

      clone = config.clone
      clone.list.action_links.names.should eq ["new"]
    end
  end
end
