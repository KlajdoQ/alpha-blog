Rails.application.routes.draw do
  resources :articles

  get 'signup', to: 'users#new'
  resources :users, except: [:new]
end
