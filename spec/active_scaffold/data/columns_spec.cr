require "./spec_helper"

private def user_columns
  ActiveScaffold::Config::Core(User).new.columns
end

describe ActiveScaffold::Data::Columns do
  it "has content columns in default" do
    columns = user_columns
    columns.map(&.name).should eq(["first_name", "last_name"])
  end

  describe "#set" do
    it "updates columns" do
      columns = user_columns
      columns.set(["id", "last_name"])
      columns.map(&.name).should eq(["id", "last_name"])

      columns.set("id")
      columns.map(&.name).should eq(["id"])
    end
  end

  describe "#add" do
    it "adds columns" do
      columns = user_columns
      columns.set("id")
      columns.map(&.name).should eq(["id"])

      columns.add("last_name")
      columns.map(&.name).should eq(["id", "last_name"])
    end
  end

  describe "#del" do
    it "deletes columns" do
      columns = user_columns
      columns.set(["id", "first_name"])
      columns.map(&.name).should eq(["id", "first_name"])

      columns.del("first_name")
      columns.map(&.name).should eq(["id"])
    end
  end

  describe "#dup" do
    it "works" do
      columns1 = user_columns
      columns1.set(["first_name", "last_name"])

      columns2 = columns1.dup
      columns2.map(&.name).should eq(["first_name", "last_name"])
      
      columns1.set("id")
      columns2.map(&.name).should eq(["first_name", "last_name"])
    end
  end
end
