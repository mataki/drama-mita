class Episode < ActiveRecord::Base
  attr_accessible :title, :num

  belongs_to :drama, :counter_cache => true
  has_many :watches

  def num_and_title
    "#{num}話 #{title}"
  end

  def recent_watchers
    User.recent_watchers_on_episode(self)
  end
end
