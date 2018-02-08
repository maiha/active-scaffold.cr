require "spec"
require "granite_orm/adapter/sqlite"
require "../src/active_scaffold"
require "file_utils"

FileUtils.mkdir_p "tmp"
Granite::ORM.settings.database_url = "sqlite3:./tmp/test.db"
Granite::ORM.settings.logger = Logger.new(nil)

require "./models"
require "./controllers"

def config
  UserController.active_scaffold_config
end

User.drop_and_create
Spec.before_each do
  User.clear
#  UserController.active_scaffold_config.reset!
end
