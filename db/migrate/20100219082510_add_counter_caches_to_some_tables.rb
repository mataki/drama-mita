class AddCounterCachesToSomeTables < ActiveRecord::Migration
  def self.up
    add_column :dramas, :episodes_count, :integer
    add_column :episodes, :watches_count, :integer
    add_column :users, :watches_count, :integer
  end

  def self.down
    remove_column :dramas, :episodes_count
    remove_column :episodes, :watches_count
    remove_column :users, :watches_count
  end
end
