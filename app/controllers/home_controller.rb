class HomeController < ApplicationController
  def index
    @friends = current_user.friends.recent_watchers.all(:limit => 3)
    @others = current_user.others.recent_watchers.all(:limit => 3)
  end
end
