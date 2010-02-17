class Watch < ActiveRecord::Base
  attr_accessible :content, :episode_id

  belongs_to :user
  belongs_to :episode

  alias_scope :friends, lambda { |user|
    user_mixi_id_is(user.friend_ids_arr)
  }

  alias_scope :not_user, lambda { |user|
    user_id_is_not(user.id)
  }

  def drama
    self.episode.try(:drama)
  end
end
