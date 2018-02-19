require "./spec_helper"

describe ActiveScaffold::Config::List do
  describe "#paging" do
    describe "#limit" do
      it "returns 15 in default" do
        config = UserController.active_scaffold_config.dup
        config.list.paging.limit.should eq(15)
      end

      it "is mutable" do
        config = UserController.active_scaffold_config.dup
        config.list.paging.limit = 10
        config.list.paging.limit.should eq(10)
      end
    end

    describe "#order" do
      it "returns primary key in default" do
        config = UserController.active_scaffold_config.dup
        config.list.paging.order.should eq("id")
      end

      it "is mutable" do
        config = UserController.active_scaffold_config.dup
        config.list.paging.order = "name desc"
        config.list.paging.order.should eq("name desc")
      end
    end
  end
end
