require "./spec_helper"

private record NamedValue, name : String, value : Int32? = 0

private class NamedFilter
  include ActiveScaffold::Data::NamedAcl(NamedValue)

  def initialize(@hash : Hash(String, NamedValue))
  end
end

private def new_filter
  hash = Hash(String, NamedValue).new
  (1..5).each{|i| hash[i.to_s] = NamedValue.new(i.to_s, i)}
  NamedFilter.new(hash)
end

private def empty
  [] of String
end

describe ActiveScaffold::Data::Columns do
  describe "#names" do
    it "returns names of current filtered values" do
      filter = new_filter
      filter.names.should eq ["1", "2", "3", "4", "5"]
    end
  end

  describe "#set" do
    it "updates filter" do
      filter = new_filter
      filter.set(["2", "3"])
      filter.names.should eq(["2", "3"])

      filter.set("3")
      filter.names.should eq(["3"])
    end

    it "respects given order" do
      filter = new_filter
      filter.set(["3", "2"])
      filter.names.should eq(["3", "2"])
    end
  end

  describe "#clear" do
    it "deletes all acls" do
      filter = new_filter
      filter.set("2")

      filter.clear
      filter.names.should eq ["1", "2", "3", "4", "5"]

      filter.set("3")
      filter.names.should eq ["3"]
    end
  end

  describe "#add" do
    it "adds items" do
      filter = new_filter
      filter.set("2")

      filter.add("4")
      filter.names.should eq ["2", "4"]
    end
  end

  describe "#del" do
    it "deletes columns" do
      filter = new_filter
      filter.del("1")
      filter.names.should eq ["2", "3", "4", "5"]

      filter.del(["3", "5", "x"])
      filter.names.should eq ["2", "4"]
    end
  end

  describe "#whites" do
    it "returns a raw object for whitelist" do
      filter = new_filter
      filter.whites.clear
      filter.whites.add "3"
      filter.names.should eq ["3"]
    end
  end

  describe "#blacks" do
    it "returns a raw object for blacklist" do
      filter = new_filter
      filter.blacks.concat(["1", "5"])
      filter.names.should eq ["2", "3", "4"]
    end
  end

  describe "(acl)" do
    it "respects blacks rather than whites" do
      filter = new_filter
      filter.set("1")
      filter.blacks.add("1")
      filter.whites.add("1")
      filter.names.should eq empty
    end
  end

  describe "#[]?" do
    it "returns an element if exists" do
      filter = new_filter
      filter["1"]?.try(&.value).should eq 1
    end

    it "returns nil if missing" do
      filter = new_filter
      filter["x"]?.should eq nil
    end
  end
  
  describe "#[]" do
    it "returns an element if exists" do
      filter = new_filter
      filter["1"].name.should eq "1"
    end

    it "builds and returns a new element if missing" do
      filter = new_filter
      filter.names.should eq ["1", "2", "3", "4", "5"]

      filter["x"].name.should eq "x"
      filter.names.should eq ["1", "2", "3", "4", "5", "x"]
    end
  end
  
  describe "#dup" do
    it "works" do
      filter1 = new_filter
      filter1.set(["1", "2"])

      filter2 = filter1.dup
      filter2.names.should eq ["1", "2"]
      
      filter1.add("3")
      filter2.names.should eq ["1", "2"]
    end
  end
end
