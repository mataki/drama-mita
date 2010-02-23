class AddTitleImageToDrama < ActiveRecord::Migration
  def self.up
    add_column :dramas, :title_image, :string
  end

  def self.down
    remove_column :dramas, :title_image
  end
end
