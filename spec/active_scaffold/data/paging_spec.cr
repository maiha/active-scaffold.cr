require "./spec_helper"

private def page(number, **args)
  page = ActiveScaffold::Data::Paging.new(**args)
  page.number = number
  return page
end

describe ActiveScaffold::Data::Paging do
  describe "#count = false" do
    it "updates type to infinite" do
      page = page(1, count: 10)
      page.type.infinite?.should be_false
      page.count = false

      page.type.infinite?.should be_true
    end

    it "keeps count value" do
      page = page(1, count: 10)
      page.count = false

      page.count.should eq 10
    end
  end

  describe "#prev?" do
    it "returns nil when current page is 1" do
      page(1).prev?.should eq nil
    end

    it "returns page(1) when current page is 2" do
      page(2).prev?.should eq page(1)
    end
  end

  describe "#next?" do
    it "returns page(2) when current page is 1" do
      page = page(1, count: 100)
      page.next?.not_nil!.number.should eq 2
    end

    it "returns nil when current page is max page number" do
      page = page(1, count: 1)
      page.next?.should eq nil
    end
  end
end
