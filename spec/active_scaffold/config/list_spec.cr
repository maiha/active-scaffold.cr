require "./spec_helper"

private def config
  UserController.active_scaffold_config
end

describe ActiveScaffold::Config::List do
  describe "#per_page" do
    it "returns 15 in default" do
      config.list.per_page.should eq(15)
    end

    it "is mutable" do
      config.list.per_page = 10
      config.list.per_page.should eq(10)
    end
  end

  describe "#sorting" do
    it "returns primary key in default" do
      config.list.sorting.should eq("id")
    end

    it "is mutable" do
      config.list.sorting = "name desc"
      config.list.sorting.should eq("name desc")
    end
  end
end
