Rails.application.routes.draw do

  get 'home/index'
  root 'home#index'

  devise_for :users

  namespace :admin do
    get '/', to: 'dashboard#index', as: '/'

    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'

    resources :archive_items do
      resources :archive_files do
        post :convert, on: :member
      end
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
