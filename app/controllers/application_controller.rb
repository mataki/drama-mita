# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'oauth/request_proxy/action_controller_request'
require 'oauth/signature/hmac/sha1'

class ApplicationController < ActionController::Base
  include MixiAppMobileController

  helper :all # include all helpers, all the time

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  mobile_filter :hankaku => true

  helper_method :current_user

private
  # FIXME: mock and move to config/initializer/mixi_app_mobile.rb
  def current_user
    @current_user ||= if valid_mixi_app_request
                        User.find_by_mixi_id(params[:opensocial_owner_id]) || User.create_by_mixi_id!(params[:opensocial_owner_id])
                      else
                        User.last
                      end
  end
end
