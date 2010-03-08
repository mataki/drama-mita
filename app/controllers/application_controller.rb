# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include MixiAppMobileController

  helper :all # include all helpers, all the time

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  mobile_filter :hankaku => true

  helper_method :current_user

  before_filter :require_user, :debug_log

  after_filter :set_content_type_for_docomo

private
  # FIXME: mock and move to config/initializer/mixi_app_mobile.rb
  def current_user
    @current_user ||= if valid_mixi_app_request
                        User.find_by_mixi_id(params[:opensocial_owner_id])
                      else
                        user_id = session[:user_id] = params[:user_id] ? params[:user_id] : (session[:user_id] || 1)
                        User.find(user_id)
                      end
  end

  def require_user
    unless current_user
      redirect_to info_url(:welcome)
    end
  end

  def set_content_type_for_docomo
    mobile = self.request.mobile
    if mobile && mobile.instance_of?(Jpmobile::Mobile::Docomo)
      self.response.content_type = "application/xhtml+xml"
    end
  end

  def debug_log
    str = <<-EOF
-- Debug ----------------------------
user   : #{params[:opensocial_owner_id]}
mobile : #{request.mobile.inspect}
------------------------------
EOF
    logger.debug str
  end
end
