class User < ActiveRecord::Base
  include MixiRest::People

  attr_accessible :name, :mixi_id, :profile_image_url, :friend_ids

  has_many :watches

  alias_scope :recent_watchers, lambda {
    watches_count_is_not(0).scoped(:order=>"watches.created_at DESC", :include => :watches)
  }

  alias_scope :recent_watchers_on_episode, lambda { |episode|
    recent_watchers.watches_episode_id_is(episode.id)
  }

  named_scope :recent_watchers_on_drama, lambda { |drama|
    { :include => {:watches => :episode}, :conditions => {:watches => {:episodes => {:drama_id => drama.id}}}, :order => "watches.created_at DESC" }
  }

  alias_scope :friends, lambda { |user|
    id_is_not(user.id).mixi_id_is(user.friend_ids_arr)
  }

  alias_scope :others, lambda { |user|
    id_is_not(user.id)
  }

  def friends
    self.class.friends(self)
  end

  def others
    self.class.others(self)
  end

  def watched_dramas
    @watched_dramas ||= Drama.watches_user_id_is(self.id).uniq{ |wache| watche.drama_id }
  end

  def watched_dramas_without_completed
    watched_dramas.select{ |drama| !drama.completed?(self) }
  end

  def completed_dramas
    watched_dramas.select{ |drama| drama.completed?(self) }
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

  def watches_count_by_drama(drama, reload = false)
    @watches_count_by_drama = {} if reload
    @watches_count_by_drama ||= {}
    @watches_count_by_drama[drama.id] ||= self.watches(reload).episode_drama_id_is(drama.id).count
  end

  def watched(episode)
    self.watches.detect{ |watch| watch.episode_id == episode.id }
  end
end
