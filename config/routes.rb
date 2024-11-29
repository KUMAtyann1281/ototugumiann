Rails.application.routes.draw do

  # ユーザー用
  # URL /users/sign_in ...
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
    root to: "homes#top"
    get "about", to:"homes#about"
    get "/search", to: "searchs#search"
    resources :notices, only: [:index,:show]
    resources :users, only: [:index,:show,:edit,:update,:destroy] do
      get "unsubscribe", on: :member
      patch 'withdraw', on: :member
      resource :favorites, only: [:create, :destroy]
      resource :relationships, only: [:create, :destroy]
    end
    resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resource :favorite, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :groups, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resource :group_users, only: [:create, :destroy]
      resources :chats, only: [:create, :destroy]
    end
  end

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    get "/" => "homes/top"
    resources :notices, only: [:new, :index, :show, :edit, :update, :destroy]
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :update, :destroy] do
      resources :comments, only: [:destroy]
    end
    resources :groups, only: [:index, :show, :edit, :update, :destroy] do
      resources :chats, only: [:destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
