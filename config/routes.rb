Rails.application.routes.draw do

  devise_for :users

  devise_for :admin, controllers: {
    sessions:      'admin/sessions'
    # passwords:     'admins/passwords',
    # registrations: 'admins/registrations'
  }

  get "" => "posts#index"
  get "users/quit" => "users#quit", as: "users_quit"
  patch "users/out" => "users#out", as: "users_out"

  resources :posts, only: [:new, :create, :show, :edit, :update, :destroy] do
    resource :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy, :edit, :update]
  end

  resources :users, only: [:show, :edit, :update] do
    member do
      get :likes
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

  namespace :admin do
    resources :posts,     only:[:index, :show, :edit, :update, :destroy]
    resources :comments,  only:[:edit, :update, :destroy]

  end


end
