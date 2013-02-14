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

    resources :districts, only: [:select] do
      collection { post :select }
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
      collection { get :partner }

      resources :restaurants, shallow: true
      resources :addresses, shallow: true
      resources :orders, shallow: true
      resources :invoices
      # resources :user_favorites, only: [:index, :create, :destroy], shallow: true

      member do
        get :restaurateur
        get :report
      end
    end

    resources :user_favorites, only: [:index, :create, :destroy]

    resources :restaurants do
      collection do
        match 'search' => 'restaurants#search', :via => [:post, :get], :as => :search
      end

      member do
        post :rate
        get :operate
        get :get_orders
        get :stats
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

    match '/faq',    to: 'static_pages#help'
    match '/about',   to: 'static_pages#about'
    match '/partners',to: 'static_pages#partners'
    match '/contact', to: 'static_pages#contact'
    match '/sushi', to: 'static_pages#sushi'
    match '/pizza', to: 'static_pages#pizza'
    match '/chinese', to: 'static_pages#chinese'
  end

  match '*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }
  match '', to: redirect("/#{I18n.default_locale}")
end
