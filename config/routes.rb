Rails.application.routes.draw do
  #get 'home/index'
  #root 'home#index'

  #get 'video/watch/:hash_id', to: 'video#watch', as: 'video_watch'
  #get 'archive/(page/:page)', to: 'archive#index', as: 'archive_page'
  #get 'search/(?q=:query)', to: 'search#index', as: 'search'
  #get 'archive/category/:category', to: 'archive#category', as: 'category'
  #get 'live-stream', to: 'live_stream#view', as: 'live_stream'

  devise_for :admins

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
    resources :video_queue_items, only: [:index, :show, :destroy] do
      get :status, on: :member, export: true
    end
    resources :video_convert_profiles

    get '/livestream', to: 'live_stream#edit'
    post '/livestream', to: 'live_stream#save'
  end

  namespace :api do
    namespace :v3 do
      resources :videos, only: [:index, :show]
      resources :categories, only: [:index, :show]
      resources :preachers, only: [:index, :show]
      resources :languages, only: [:index, :show]
      get '/categories/:id/videos', to: 'categories#videos_in_category'
      get '/live-stream', to: 'live_stream#show'
      get '/popular-videos', to: 'videos#popular'
    end
  end

end
