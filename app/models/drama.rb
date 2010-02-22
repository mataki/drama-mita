class Drama < ActiveRecord::Base
  attr_accessible :title

  belongs_to :category
  has_many :episodes
  has_many :watches, :through => :episodes

  cattr_reader :per_page
  @@per_page = 5

  named_scope :populer, lambda {
    {:select => "sum(watches_count) AS sum_watches_count, dramas.*", :joins => :episodes, :group => "drama_id", :order => "sum_watches_count DESC"}
  }

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

  def create_all_episodes_watches(user)
    episodes.map do |episode|
      episode.watches.create(:user => user)
    end
  end
end
