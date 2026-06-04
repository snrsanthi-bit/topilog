Rails.application.routes.draw do
  get 'events/new'
  devise_for :users
  root "static_pages#top"

  resources :events, only: [:new, :create, :index, :show]
end