class Drama < ActiveRecord::Base
  attr_accessible :title

  belongs_to :category
  has_many :episodes
  has_many :watches, :through => :episodes

  named_scope :populer do
    {}
  end

  def self.current_episodes
    all_dramas = all
    channels.inject({}) do |res, k|
      res.update(k => all_dramas.rand.episodes.rand)
    end
  end

  def completed?(user)
    user.watches_count_by_drama(self) >= self.episodes.count
  end

  def complete_rate(user)
    "#{user.watches_count_by_drama(self)}/#{self.episodes.count}"
  end
end
