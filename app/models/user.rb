class User < ActiveRecord::Base
  attr_accessible :name, :mixi_id

  has_many :watches
end
