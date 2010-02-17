class User < ActiveRecord::Base
  attr_accessible :name, :mixi_id

  has_many :watches

  # FIXME: mock
  def friends
    User.id_is_not(self.id)
  end

  # FIXME: mock
  def watched_dramas
    Drama.watches_user_id_is(self.id).uniq{ |wache| watche.drama_id }
  end

  # FIXME: mock
  def self.create_by_mixi_id(mixi_id)
    user_data = get_user_data(mixi_id)
    self.create(:mixi_id => mixi_id, :name => user_data["displayName"], :profile_image_url => user_data["thumbnailUrl"])
  end

  def self.get_user_data(mid)
    return @self_data if @self_data
    consumer = OAuth::Consumer.new(ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'])
    path = "http://api.mixi-platform.com/os/0.8/people/@me/@self"
    params = { :xoauth_requestor_id => mid, :format => "json" }
    url = path + "?" + params.to_query
    resp = consumer.request(:get, url, nil, { :scheme => :query_string })
    @self_data = JSON.parse(resp.body)["entry"]
  end

  def get_user_data
    self.class.get_user_data(self.mixi_id)
  end
end
