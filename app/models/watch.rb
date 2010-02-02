class Watch < ActiveRecord::Base
  attr_accessible :content, :episode_id

  belongs_to :user
  belongs_to :episode

  named_scope :populer do
    {}
  end

  named_scope :friends do |user|
    {}
  end

  def drama
    self.episode.try(:drama)
  end
end
