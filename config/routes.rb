Rails.application.routes.draw do
  root to: 'home#index'
  
  devise_for :users

  get 'search', to: "home#search"

  resources :categories

  resources :promotions do	  
    member do 
      post 'generate_coupons'
      post 'approve'
    end
  end
  
  resources :coupons, only: [] do	  
    post 'disable', on: :member
  end
end
