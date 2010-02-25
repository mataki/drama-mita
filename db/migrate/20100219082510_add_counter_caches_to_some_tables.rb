class AddCounterCachesToSomeTables < ActiveRecord::Migration
  def self.up
    add_column :dramas, :episodes_count, :integer, :nill => false, :default => 0
    add_column :episodes, :watches_count, :integer, :nill => false, :default => 0
    add_column :users, :watches_count, :integer, :nill => false, :default => 0
  end

  def self.down
    remove_column :dramas, :episodes_count
    remove_column :episodes, :watches_count
    remove_column :users, :watches_count
  end
end
