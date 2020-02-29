Rails.application.routes.draw do
  namespace :api do
    get 'product_controller/all'
    get 'index_new_controller/all'
    get 'work_controller/all'
  end
  namespace :api do
    resources :products, only: %i[index create update show destroy] do

    end
    resources :works, only: %i[index create update show destroy] do

    end
    resources :index_news, only: %i[index create update show destroy] do

    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html





end