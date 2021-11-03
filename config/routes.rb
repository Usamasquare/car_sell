Rails.application.routes.draw do
  root to: 'ads#index'
  devise_for :users
  resources :ads
  resources :post_ad_steps
  get 'finalize',to: 'ads#finalize'
  get 'checkout',to: 'checkouts#show'
end
