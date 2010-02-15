class HomeController < ApplicationController
  def index
    @friends_watches = Watch.friends(current_user).all(:limit => 3)
    @recent_watches = Watch.all(:limit => 3)
  end
end
