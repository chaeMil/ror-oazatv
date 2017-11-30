Rails.application.routes.draw do

  get 'home/index'
  root 'home#index'

  devise_for :users

  namespace :admin do
    get '/', to: 'dashboard#index', as: '/'

    resources :archive_items do
      resources :archive_files
    end

    resources :languages
    resources :categories
    resources :preachers
    resources :songs
    resources :photo_albums do
      resources :photos
    end
  end

end
