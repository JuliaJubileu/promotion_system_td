Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

<<<<<<< HEAD
  resources :categories

  resources :promotions do	  
=======
  resources :promotions do
>>>>>>> af97c791456378dc41b8fec153ac32d908243764
    member do 
      post 'generate_coupons'
      post 'approve'
    end
  end
<<<<<<< HEAD

  resources :coupons, only: [] do	  
=======
  
  resources :coupons, only: [] do
>>>>>>> af97c791456378dc41b8fec153ac32d908243764
    post 'disable', on: :member
  end
end
