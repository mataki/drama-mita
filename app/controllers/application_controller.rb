# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'oauth/request_proxy/action_controller_request'
require 'oauth/signature/hmac/sha1'

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  mobile_filter :hankaku => true

  before_filter :valid_mixi_app_mobile_request?

  helper_method :current_user

  attr_reader :valid_mixi_app_request

private
  # FIXME: mock
  def current_user
    if valid_mixi_app_request
      User.find_by_mixi_id(params[:opensocial_owner_id]) || User.create_by_mixi_id(params[:opensocial_owner_id])
    else
      User.last
    end
  end

  def valid_mixi_app_mobile_request?
    unless OAuth::Signature.verify(request, :consumer_secret => ENV['CONSUMER_SECRET'])
      render "public/500.html"
    else
      @valid_mixi_app_request = true
    end
  rescue OAuth::Signature::UnknownSignatureMethod => e
    logger.info e
  rescue => e
    logger.info e
  end

  # FIXME: mock
  def url_for_with_mixi_app_mobile_traverse(args)
    if valid_mixi_app_request
      url = url_for_without_mixi_app_mobile_traverse(args)
      uri = URI.parse(url)
      unless uri.host
        root_url = url_for_without_mixi_app_mobile_traverse(:controller => "home", :only_path => false)
        url = URI.join(root_url, url)
      end
      "?url=#{URI.escape(url.to_s)}"
    else
      url_for_without_mixi_app_mobile_traverse(args)
    end
  end
  alias_method_chain :url_for, :mixi_app_mobile_traverse
end
