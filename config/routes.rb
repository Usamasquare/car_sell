Rails.application.routes.draw do
  root to: 'ads#index'
  devise_for :users
  resources :ads
  resources :post_ad_steps
  get 'my_posts',to: 'ads#my_posts'
  #get 'checkout',to: 'checkouts#show'
  #get 'success',to: 'checkouts#success'
  resources :checkouts, only: :show do
    collection do
      get :success
    end
  end

end
