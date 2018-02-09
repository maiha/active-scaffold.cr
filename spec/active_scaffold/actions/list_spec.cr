require "./spec_helper"

private class UserControllerMock
  include ActiveScaffold(User)
end

describe ActiveScaffold::Actions::List do
  describe "#index" do
    it "returns a model name in default" do
      controller = UserControllerMock.new
#      controller.index
    end
  end
end
