class CreateDramas < ActiveRecord::Migration
  def self.up
    create_table :dramas do |t|
      t.string :title
      t.references :category
      t.timestamps
    end
  end
  
  def self.down
    drop_table :dramas
  end
end
