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
    self.create(:mixi_id => mixi_id, :name => "てすと1")
  end

  def get_user_data
    consumer = OAuth::Consumer.new(ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'], { :site => 'http://api.mixi-platform.com/os/0.8' })
    path = "/people/@me/@self"
    params = { :xoauth_requestor_id => mixi_id, :format => "json" }
    url = path + "?" + params.to_query
    logger.info "url: #{url}"
    resp = consumer.request(:get, url, nil, { :scheme => :query_string })
    logger.info "body: #{resp.body}"
    logger.info "header: #{resp.to_hash}"
    logger.info resp
  end
end
