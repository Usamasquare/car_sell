Rails.application.routes.draw do
  root to: 'ads#index'
  devise_for :users
  resources :ads do
    member do
      get :favorites
      get :close
    end
    collection do
      get :my_posts
      get :myfavorites
    end
  end
  resources :post_ad_steps
  resources :checkouts, only: :show do
    collection do
      get :success
    end
  end
end
