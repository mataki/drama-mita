class Episode < ActiveRecord::Base
  attr_accessible :title, :num

  belongs_to :drama
  has_many :watches

  def num_and_title
    "#{num}話 #{title}"
  end
end
