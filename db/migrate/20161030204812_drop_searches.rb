class DropSearches < ActiveRecord::Migration
  def up
  	drop_table :searches
  end
  
  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
