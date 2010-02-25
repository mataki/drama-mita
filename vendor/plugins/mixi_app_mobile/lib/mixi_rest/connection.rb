require "singleton"
require 'hashie'

module MixiRest
  class Connection
    include Singleton

    def initialize()
      @@consumer = OAuth::Consumer.new(ENV["CONSUMER_KEY"], ENV["CONSUMER_SECRET"])
      @@site = "http://api.mixi-platform.com/os/0.8/"
    end

    def request(requestor_id, path, method = :get, request_options = {}, *arguments)
      default_query = { :xoauth_requestor_id => requestor_id, :format => "json" }
      uri = URI.parse(path)
      uri.query = default_query.update((uri.query||{})).to_query
      url_with_site = URI.join(@@site, uri.to_s).to_s
      ::Rails.logger.info "[MixiRest] request => #{method}: #{url_with_site}"
      resp = @@consumer.request(method, url_with_site, nil, request_options.update(:scheme => :query_string), *arguments)
      ::Rails.logger.info "[MixiRest] resp => #{resp.inspect}"
      ::Rails.logger.info "[MixiRest] resp => #{resp.body}"
      return true if resp.code == "200" and (resp.body.blank? or resp.body == "true")
      Hashie::Mash.new(JSON.parse(resp.body))
    rescue => e
      if MixiAppMobileController.reject_invalid_access
        raise e
      else
        ::Rails.logger.error "[MixiRest] failed"
        return false
      end
    end
  end
end
