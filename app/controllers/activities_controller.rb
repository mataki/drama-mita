class ActivitiesController < ApplicationController
  before_filter :load_activity

  def new
  end

  def create
    MixiRest::Activities.request(current_user.mixi_id, @activity[:title], @activity[:url])
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
