Rails.application.routes.draw do
  root 'home#index'
  get 'search', to: "home#search"
  devise_for :users

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
