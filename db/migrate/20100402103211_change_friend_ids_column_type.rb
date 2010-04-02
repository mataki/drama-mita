class ChangeFriendIdsColumnType < ActiveRecord::Migration
  def self.up
    change_column :users, :friend_ids, :text
  end

  def self.down
    change_column :users, :friend_ids, :string
  end
end
