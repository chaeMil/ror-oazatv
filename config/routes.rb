Rails.application.routes.draw do

  resources :photo_albums
  get 'home/index'
  root 'home#index'

  devise_for :users

  namespace :admin do
    get '/', to: 'dashboard#index', as: '/'

    resources :archive_items do
      resources :archive_files, only: [:create, :new, :show, :destroy]
    end

    resources :languages
    resources :categories
    resources :preachers
    resources :songs
  end

end
