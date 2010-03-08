class AddAmbiguousTitileToDrama < ActiveRecord::Migration
  def self.up
    add_column :dramas, :ambiguous_title, :string
  end

  def self.down
    remove_column :dramas, :ambiguous_title
  end
end
