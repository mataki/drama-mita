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
    if params[:opensocial_owner_id]
      User.find_by_mixi_id(params[:opensocial_owner_id]) || User.create_by_mixi_id(params[:opensocial_owner_id])
    else
      User.last
    end
  end

  def valid_mixi_app_mobile_request?
    unless OAuth::Signature.verify(request, :consumer_secret => ENV['CONSUMER_SECRET'])
      render "public/500.html"
    end
  rescue OAuth::Signature::UnknownSignatureMethod => e
    logger.info e
  rescue => e
    logger.info e
  end
end
