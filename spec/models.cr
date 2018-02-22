class User < Granite::ORM::Base
  adapter sqlite
  field first_name : String
  field last_name : String
  field created_at : Time
  field updated_at : Time

  def name : String
    names.join(" ")
  end

  def names : Array(String)
    [first_name, last_name].compact
  end
  
  def self.drop_and_create
    exec "DROP TABLE IF EXISTS users"
    exec <<-SQL
      CREATE TABLE users (
        id INTEGER NOT NULL PRIMARY KEY,
        first_name VARCHAR(255),
        last_name VARCHAR(255),
        created_at datetime,
        updated_at datetime
      )
      SQL
  end
end
