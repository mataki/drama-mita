class Drama < ActiveRecord::Base
  attr_accessible :title

  belongs_to :category
  has_many :episodes
  has_many :watches, :through => :episodes

  named_scope :populer do
    {}
  end

  validates_inclusion_of :channel, :in => Channel.keys

  def self.channels
    Channel.keys
  end

  def self.current_episodes
    all_dramas = all
    channels.inject({}) do |res, k|
      res.update(k => all_dramas.rand.episodes.rand)
    end
  end
end
