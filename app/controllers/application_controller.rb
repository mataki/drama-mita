# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'oauth/request_proxy/action_controller_request'
require 'oauth/signature/hmac/sha1'

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  mobile_filter :hankaku => true

  before_filter :valid_mixi_app_mobile_request?

  helper_method :current_user

  attr_reader :valid_mixi_app_request

private
  # FIXME: mock
  def current_user
    @current_user ||= if valid_mixi_app_request
                        User.find_by_mixi_id(params[:opensocial_owner_id]) || User.create_by_mixi_id(params[:opensocial_owner_id])
                      else
                        User.mixi_id_null.last
                      end
  end

  def valid_mixi_app_mobile_request?
    logger.debug request.headers.map{|k,v| "{#{k}:#{v}}"}.join(" : ")
    mixi_request = OAuth::RequestProxy::ActionControllerRequestForMixi.new(request)
    unless OAuth::Signature.verify(mixi_request, :consumer_secret => ENV['CONSUMER_SECRET'])
      render "public/500.html"
    else
      @valid_mixi_app_request = true
    end
  rescue OAuth::Signature::UnknownSignatureMethod => e
    logger.info e
  rescue => e
    logger.info e
  end
end
