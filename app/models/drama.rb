class Drama < ActiveRecord::Base
  attr_accessible :title

  belongs_to :category
  has_many :episodes, :order => "num ASC"
  has_many :watches, :through => :episodes

  cattr_reader :per_page
  @@per_page = 5

  named_scope :populer, lambda {
    {:select => "sum(CASE WHEN episodes.watches_count is null THEN 0 ELSE episodes.watches_count END) AS sum_watches_count, dramas.*", :joins => :episodes, :group => "dramas.id, dramas.title, dramas.category_id, dramas.created_at, dramas.updated_at, dramas.episodes_count, dramas.title_image", :order => "sum_watches_count DESC"}
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
