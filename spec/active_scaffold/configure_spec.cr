require "./spec_helper"

private class UserConfig
  include ActiveScaffold(User)
end

private def global
  UserConfig.active_scaffold_config
end

describe ActiveScaffold::Configure do
  it "provides .active_scaffold_config" do
    UserConfig.active_scaffold_config.should be_a(ActiveScaffold::Config::Core(User))
  end

  it "provides #active_scaffold_config" do
    UserConfig.new.active_scaffold_config.should be_a(ActiveScaffold::Config::Core(User))
  end

  describe ".active_scaffold_config (global)" do
    it "is not same object with local config" do
      local = UserConfig.new.active_scaffold_config
      (global.object_id != local.object_id).should be_true
    end

    it "affects local config creation" do
      global.columns = ["id"]
      local = UserConfig.new.active_scaffold_config
      local.columns.names.should eq(["id"])
    end

    it "doesn't affect existing local configs" do
      local = UserConfig.new.active_scaffold_config

      local.columns = ["id"]
      global.columns = ["first_name"]

      local.columns.names.should eq(["id"])
    end
  end
end
