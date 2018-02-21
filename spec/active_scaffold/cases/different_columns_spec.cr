require "./spec_helper"

describe "[case] It has different values for each configs." do
  it "has different values for configs" do
    config = UserController.active_scaffold_config.clone

    config.columns.object_id.should_not eq config.list.columns.object_id
    config.columns["id"].object_id.should_not eq config.list.columns["id"].object_id
  end
end
