ActionController::Routing::Routes.draw do |map|
  map.root :controller => "watches"

  map.resources :watches

  map.resources :episodes

  map.resources :dramas

  map.resources :users

  map.resources :categories
end
