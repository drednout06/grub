Grub::Application.routes.draw do
  scope :path => "(:locale)", :shallow_path => "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

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

    resources :addresses, only: [:index]
    resources :orders
    resources :dishes, only: [:index]

    resources :users do
      resources :restaurants, shallow: true
      resources :addresses, shallow: true
      resources :orders, shallow: true
    end

    resources :restaurants do
      resources :menus, shallow: true
      resources :orders, shallow: true
    end

    resources :menus, only: [:index] do
      resources :dishes, shallow: true
    end

    #resources :sessions, only: [:new, :create, :destroy]

    root to: 'static_pages#home'

    #match '/signup',  to: 'users#new'
    #match '/signin',  to: 'sessions#new'
    #match '/signout', to: 'sessions#destroy'

    match '/help',    to: 'static_pages#help'
    match '/about',   to: 'static_pages#about'
    match '/contact', to: 'static_pages#contact'
  end

  match '*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }
  match '', to: redirect("/#{I18n.default_locale}")


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
