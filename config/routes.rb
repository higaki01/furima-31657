Rails.application.routes.draw do
  get 'avatars/update'
  get 'avatars/destroy'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations:      'users/registrations',
    sessions:           'users/sessions'
  }

  devise_scope :user do
    get     'users/registration', to: 'users/registrations#new_index'
    get     'users/addresses',    to: 'users/registrations#new_address'
    post    'users/addresses',    to: 'users/registrations#create_address'
    get     'users/cards',        to: 'users/registrations#new_card'
    post    'users/cards',        to: 'users/registrations#create_card'
    post    'users/completion',   to: 'users/registrations#create_completion'
  end

  root to: "items#index"
  
  resources :items do
    resources :purchases, only: [:index, :create]
    resources :favorites, only: [:create]
    collection do
      get 'search_tag'
      get 'search_item'
    end
  end

  resources :mypages, only: [:show] do
    member do
      get     'sale'
      get     'sold'
      get     'buy'
      get     'address'
      post    'create_address'
      delete  'destroy_address'
      get     'card'
      post    'create_card'
      delete  'destroy_card'
      get     'info'
    end
  end

  resources :avatars, only: [:create, :update, :destroy]
  resources :messages, only:[:create]
end
