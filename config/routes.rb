Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  namespace :admin do
    resources :archive_items do
      resources :archive_files, only: [:create, :new, :show, :destroy]
    end
  end

end
