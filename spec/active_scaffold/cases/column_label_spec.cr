require "./spec_helper"

describe "[case] Column labels" do
  it "capitalizes column name in default" do
    config = UserController.active_scaffold_config.clone

    config.columns["id"].label.should eq("Id")
    config.show.columns["id"].label.should eq("Id")
  end

  it "translates '_' as space" do
    config = UserController.active_scaffold_config.clone

    config.columns["run_at"].label.should eq("Run At")
    config.show.columns["run_at"].label.should eq("Run At")
  end

  it "can be set by user" do
    config = UserController.active_scaffold_config.clone
    config.columns["id"].label = "ID"

    config.columns["id"].label.should eq("ID")
    config.list.columns["id"].label.should eq("ID")
  end
end
