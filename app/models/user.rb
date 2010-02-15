class User < ActiveRecord::Base
  attr_accessible :name, :mixi_id

  has_many :watches

  # FIXME: mock
  def friends
    User.id_is_not(self.id)
  end

  # FIXME: mock
  def watched_dramas
    Drama.watches_user_id_is(self.id).uniq{ |wache| watche.drama_id }
  end

  # FIXME: mock
  def self.create_by_mixi_id(mixi_id)
    self.create(:mixi_id => mixi_id, :name => "てすと1")
  end
end
