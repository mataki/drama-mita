class HomeController < ApplicationController
  def index
    @current_episodes = Drama.current_episodes

    @recent_watches = Watch.populer.all
    @friends_watches = Watch.friends(current_user).all
  end
end
