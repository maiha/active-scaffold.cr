require "./spec_helper"

private def config
  UserController.active_scaffold_config.clone
end

describe "[case] default values" do
  it "is defined" do
    config.list.actions.names.should eq ["new", "list", "show", "edit"]
  end
end
