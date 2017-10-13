Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  mount Ckeditor::Engine => '/ckeditor'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#config/routes.rb

  root to: "posts#index"

  resources :posts do
  	resources :comments
  end

  resources :comments do
  	resources :comments
  end

end
