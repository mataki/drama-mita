class ActivitiesController < ApplicationController
  before_filter :load_activity

  def new
  end

  def create
    begin
      MixiRest::Activities.request(current_user.mixi_id, @activity[:title], @activity[:url])
    rescue MixiRest::Connection::InvalidResponse => exception
      Exceptional::Catcher.handle_with_controller(exception, self, request)
      Exceptional.context.clear!
    end
    redirect_to @activity[:return_to] || root_url
  end

  def cancel
    redirect_to @activity[:return_to] || root_url
  end
private
  def load_activity
    unless @activity = session[:activity]
      redirect_to root_url
    end
  end
end
