Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  resources :archive_items
end
