Rails.application.routes.draw do
  namespace :api do
    get 'product_controller/all'
    get 'index_new_controller/all'
    get 'work_controller/all'
  end
  namespace :api do
    resources :products, only: %i[index create update show destroy] do
      collection do
        post 'get_by_desc', action: :get_by_desc
      end


    end
    resources :subscribers, only: %i[index create update show destroy] do
      collection do
        post 'subscribe', action: :subscribe
      end
    end
    resources :works, only: %i[index create update show destroy] do
      collection do
        get 'index_gallery/:id', action: :index_for_gallery
        get 'index_gallery_url/:id', action: :index_for_gallery_url
        get 'index_menu/', action: :index_for_menu
      end
    end
    resources :index_news, only: %i[index create update show destroy] do
      collection do
        get 'index_pp', action: :index_principal_pages
        get 'info_new/:id', action: :info_new
        get 'all_news', action: :index_for_index
      end
    end
    resources :our_works, only: %i[index create update show destroy] do
      collection do
        get 'info_our_works/:id', action: :info_our_works
        get 'index_for_menu', action: :index_for_menu

      end
    end

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html





end