Rails.application.routes.draw do
  root to: 'ads#index'
  devise_for :users
  resources :ads do
    member do
      get :favorites
    end
    collection do
      get :myfavorites
    end
  end
  resources :post_ad_steps
  get 'my_posts',to: 'ads#my_posts'
  resources :checkouts, only: :show do
    collection do
      get :success
    end
  end
end
