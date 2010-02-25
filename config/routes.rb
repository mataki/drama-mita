ActionController::Routing::Routes.draw do |map|
  map.root :controller => "home", :action => "index"

  map.resources :watches, :only => %w(create update destroy)

  map.resources :episodes do |episode|
    episode.resources :watches, :only => :index
  end

  map.resources :dramas

  map.resources :users, :collection => { :me => :get }

  map.resources :categories

  map.info "/info/:action", :controller => "info"
end
