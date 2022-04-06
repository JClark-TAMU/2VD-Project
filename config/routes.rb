Rails.application.routes.draw do
  resources :albums do
    member do
      get 'add'
      get 'user'
      patch 'link'
    end
  end
  resources :galleries do
    member do
      get 'submit'
      patch 'add'
    end
  end
  resources :images do
    member do
      patch 'unlink'
      patch 'unalbum'
    end
  end
  resources :portfolios
  get '/users/officers', to: 'users#officers', as: 'officer'
  resources :users
  root to: 'dashboards#show'
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end
end
