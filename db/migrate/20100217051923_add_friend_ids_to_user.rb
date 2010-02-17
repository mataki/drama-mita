class AddFriendIdsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :friend_ids, :string
  end

  def self.down
    remove_column :users, :friend_ids
  end
end
