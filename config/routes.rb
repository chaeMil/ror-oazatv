Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'

  resources :archive_items
  resources :archive_files

  get 'archive_items/:id/files', to: 'archive_items#create_archive_file', as: 'create_archive_file'
end
