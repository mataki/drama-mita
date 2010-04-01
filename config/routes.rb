ActionController::Routing::Routes.draw do |map|
  map.root :controller => "home", :action => "index"

  map.resources :watches, :only => %w(create update destroy)

  map.resources :episodes do |episode|
    episode.resources :watches, :only => :index
  end

  map.resources :dramas, :collection => { :search => :post }

  map.resources :users, :collection => { :me => :get }

  map.resources :categories

  map.resource :activity, :only => %w(new create), :collection => { :cancel => :post }

  map.info "/info/:action", :controller => "info"
end
