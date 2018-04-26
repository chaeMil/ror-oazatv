Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  get 'video/watch/:hash_id', to: 'video#watch', as: 'video_watch'
  get 'archive/page/:page', to: 'archive#page', as: 'archive_page', defaults: {page: 1}

  devise_for :users

  namespace :admin do
    get '/', to: 'dashboard#index'

    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'

    resources :archive_items, export: true do
      resources :archive_files, export: true do
        post :convert, on: :member
      end
    end

    post '/archive_files/chunk', to: 'archive_files#post_chunk'
    get '/archive_files/chunk', to: 'archive_files#get_chunk'

    resources :languages
    resources :categories
    resources :preachers
    resources :songs
    resources :photo_albums do
      resources :photos
    end
    resources :video_queue_items, only: [:index, :show, :destroy] do
      get :status, on: :member, export: true
    end
    resources :video_convert_profiles

    get '/livestream', to: 'live_stream#edit'
    post '/livestream', to: 'live_stream#save'
  end

end
