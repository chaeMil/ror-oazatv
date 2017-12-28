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

    resources :video_queue_items, only: [:index, :show, :destroy]
    resources :languages
    resources :categories
    resources :preachers
    resources :songs
    resources :photo_albums do
      resources :photos
    end
  end

end
