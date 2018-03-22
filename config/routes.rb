Rails.application.routes.draw do

  get 'home/index'
  root 'home#index'

  devise_for :users

  namespace :admin do
    get '/', to: 'dashboard#index'

    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'

    mount Uploader::Engine => '/uploader'

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
    resources :video_queue_items, only: [:index, :show, :destroy]
    resources :video_convert_profiles

    get '/livestream', to: 'live_stream#edit'
    post '/livestream', to: 'live_stream#save'
  end

end
