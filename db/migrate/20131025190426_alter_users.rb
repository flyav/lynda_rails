class AlterUsers < ActiveRecord::Migration
  def change
  	rename_table("users", "admin_users")
  	add_column("admin_users", "username", :string, :limit => 25)
  	change_column("admin_users", "email", :string, :limit => 100)
  	rename_column("admin_users", "password", "hashed_password")
  	add_column("admin_users", "salt", :string, :limit => 40)
  	puts "**** About to add an index ****"
  	add_index("admin_users", "username")
  end
  def self.up
   change_column("admin_users", "email", :string, :limit => 100)
  end
  def self.down
   change_column("admin_users", "email", :default => "", :null => false)
  end
end
