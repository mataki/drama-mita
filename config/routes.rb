ActionController::Routing::Routes.draw do |map|
  map.root :controller => "home", :action => "index"

  map.resources :watches

  map.resources :episodes

  map.resources :dramas

  map.resources :users, :collection => { :me => :get }

  map.resources :categories

  map.info "/info/:action", :controller => "info"
end
