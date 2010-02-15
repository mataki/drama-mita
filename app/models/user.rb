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
end
