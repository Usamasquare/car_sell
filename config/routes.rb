Rails.application.routes.draw do
  resources :ads
  resources :post_ad_steps
  devise_for :users
  get 'finalize',to: 'ads#finalize'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'ads#index'
  
end
