class Watch < ActiveRecord::Base
  attr_accessible :content, :episode_id, :drama_id, :user_id, :user, :episode

  belongs_to :user, :counter_cache => true
  belongs_to :episode, :counter_cache => true

  validates_uniqueness_of :episode_id, :scope => :user_id

  attr_accessor :drama_id

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
