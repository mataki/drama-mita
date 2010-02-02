class Episode < ActiveRecord::Base
  attr_accessible :title, :num

  belongs_to :drama
  has_many :watches
end
