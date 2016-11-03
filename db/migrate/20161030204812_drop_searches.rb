class DropSearches < ActiveRecord::Migration
  def up

  end
  
  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
