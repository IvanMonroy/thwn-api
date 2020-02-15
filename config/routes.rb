Rails.application.routes.draw do
  namespace :api do
    get 'product_controller/all'
  end
  namespace :api do
    resources :products, only: %i[index create update show destroy] do

    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html





end