class User < ActiveRecord::Base
  include MixiRest::People

  attr_accessible :name, :mixi_id, :profile_image_url, :friend_ids

  has_many :watches

  def friends
    User.id_is_not(self.id).find_all_by_mixi_id(friend_ids_arr)
  end

  def watched_dramas
    Drama.watches_user_id_is(self.id).uniq{ |wache| watche.drama_id }
  end

  def self.create_by_mixi_id!(mixi_id)
    user = self.new(:mixi_id => mixi_id)
    user.name = user.me_self.displayName
    user.profile_image_url = user.me_self.thumbnailUrl
    user.friend_ids = user.fetch_friend_ids.join(',')
    user.save
    user
  end

  def friend_ids_arr
    friend_ids ? friend_ids.split(',') : []
  end
end
