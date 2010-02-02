class Drama < ActiveRecord::Base
  attr_accessible :title

  belongs_to :category
  has_many :episodes

  named_scope :populer do
    {}
  end
end
