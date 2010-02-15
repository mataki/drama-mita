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

private
  # FIXME: mock
  def current_user
    User.last
  end

  def valid_mixi_app_mobile_request?
    logger.info request.headers.map{|k,v| "{#{k}:#{v}}"}.join(" : ")
    oauth_request = OAuth::RequestProxy.proxy(request)
    logger.info OAuth::Signature.sign(oauth_request, :consumer_secret => ENV['CONSUMER_SECRET'])
  rescue => e
    logger.info e
  end
end
