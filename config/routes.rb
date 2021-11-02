Rails.application.routes.draw do
  resources :ads
  resources :post_ad_steps
  devise_for :users
  get 'finalize',to: 'ads#finalize'

  root to: 'ads#index'
end
