class AddMissingIndexes < ActiveRecord::Migration
  def self.up

    # These indexes were found by searching for AR::Base finds on your application
    # It is strongly recommanded that you will consult a professional DBA about your infrastucture and implemntation before
    # changing your database in that matter.
    # There is a possibility that some of the indexes offered below is not required and can be removed and not added, if you require
    # further assistance with your rails application, database infrastructure or any other problem, visit:
    #
    # http://www.railsmentors.org
    # http://www.railstutor.org
    # http://guides.rubyonrails.org


    add_index :watches, :user_id
    add_index :watches, :episode_id
    add_index :episodes, :drama_id
    add_index :dramas, :category_id

    add_index :watches, :id
    add_index :episodes, :id
    add_index :dramas, :id
    add_index :users, :id
    add_index :categories, :id

    add_index :users, :mixi_id
  end

  def self.down
    remove_index :watches, :user_id
    remove_index :watches, :episode_id
    remove_index :episodes, :drama_id
    remove_index :dramas, :category_id

    remove_index :watches, :id
    remove_index :episodes, :id
    remove_index :dramas, :id
    remove_index :users, :id
    remove_index :categories, :id
  end
end
