Rails.application.routes.draw do

  get 'evaluations/index'

  get 'evaluations/show'

  get 'evaluations/new'

  get 'evaluations/result'

  root "home#index"
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',  registrations: 'users/registrations', passwords: 'users/passwords'
  }

  resources :interviews

  resources :recruitments do
    collection do
      get :recommend
    end
  end

  resources :user_recruitments, only: [:create]

  resources :sms, only: [:create]

  resources :user, only:[:update] do
    collection do
      get :show
      get :my_projects
      get :my_courses
      get :my_messages
      get :my_recruits
      get :my_resumes
    end
end

  resources :votes, only: [:create]

  #get "/courses/list", to: "courses#list", as: :list_courses
  resources :courses, only: [:index, :show] do
    collection do
      get :list
    end
    member do
      get :detail
    end
    resources :sub_courses, only: [:index, :show, :create]
  end

  namespace :admin do
    root "home#index"
    resources :colleges
    resources :teachers
    resources :recruitments
    resources :categories
    resources :courses do
      resources :sub_courses
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
