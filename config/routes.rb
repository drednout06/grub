Grub::Application.routes.draw do


  scope :path => "(:locale)", :shallow_path => "(:locale)", locale: /en|kk|ru/ do
    root to: 'static_pages#home'
    
    devise_for :users

    ActiveAdmin.routes(self)

    resources :line_items do
      member do
        post 'decrement'
        post 'increment'
      end
    end

    resources :cities do
      resources :districts, shallow: true
    end

    resources :carts
    
    resources :cuisines do
      collection do
        post :sort
      end
    end

    resources :addresses, only: [:index]

    resources :orders do
      collection { get :update_address }

      member do
        post :accept
        post :reject
      end
    end
    
    resources :dishes, only: [:index]

    resources :users do
      resources :restaurants, shallow: true
      resources :addresses, shallow: true
      resources :orders, shallow: true
      # resources :user_favorites, only: [:index, :create, :destroy], shallow: true

      member do
        get :restaurateur
      end
    end

    resources :user_favorites, only: [:index, :create, :destroy]

    match 'restaurants/search' => 'restaurants#index', :via => [:post, :get]

    resources :restaurants do
      collection do
        post :search, to: 'restaurants#index'
      end

      member do
        post :rate
        get :operate
        get :get_orders
      end
      
      resources :menus, shallow: true do
        collection do
          post :sort
        end

        resources :dishes, shallow: true do
          collection do
            post :sort
          end
        end
      end

      resources :orders, shallow: true
      resources :reviews, shallow: true
      resources :business_hours, shallow: true
      resources :deliverabilities, shallow: true
    end

    match '/help',    to: 'static_pages#help'
    match '/about',   to: 'static_pages#about'
    match '/contact', to: 'static_pages#contact'
  end

  match '*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }
  match '', to: redirect("/#{I18n.default_locale}")
end
