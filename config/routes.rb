Rails.application.routes.draw do

  mount WeixinRailsMiddleware::Engine, at: "/"
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

  resources :evaluations do
    collection do
      get :result
    end
  end

  resources :user_recruitments, only: [:create] do
    collection do
      get :agree
    end
  end

  resources :sms, only: [:create]

  resources :user, only:[:show, :update] do
    collection do
      get :my_projects
      get :my_courses
      get :my_messages
      get :my_recruits
      get :my_resumes
    end
  end

  resources :user_projects do
    member do
      post :invited, :uninvited
      patch :invited, :uninvited
    end
  end
  resources :user_notifications do
    collection do
      get :read_all
    end
    member do
      get :read
    end
  end

  resources :votes, only: [:create]
  resources :ints, only: [:create]

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

  #职前培训
  resources :worktrains, only: [:index, :show]

  #实训项目
  namespace :training_platform do
    root 'projects#index'

    resources :projects do
      
      resources :tasks do
        member do
          get :aasm_state
          get :move_category
          post :tag
          get :update_principal
          get :level
          get :remove
          post :add_helper
          post :set_end_time
          delete :remove_helper
          post :upload
          delete :remove_attachment
          get :download
        end
      end

      resources :courses, only: :index

      resources :project_courses do
        collection do
          post :batch_create
        end
      end

      resources :announces

      resources :notifications do
        collection do
          post :validate
        end
      end

      resources :task_categories #任务列表

      match 'tagged' => 'task_categories#tagged', :as => 'tagged', via: 'post'

      resources :users, only: :show

      resources :user_projects do
        collection do
          get :invite_member
        end
      end

      #实训项目通知读取
      resources :user_notifications, only: :index do
        collection do
          get :read_all
        end
        member do
          get :read
        end
      end

    end

    resources :comments, only: [:create, :destroy, :index]
  end

  #api管理
  namespace :api do
    resources :users, only: [:index]
  end

  resources :projects
  resources :cooperations, only: [:index]


  namespace :admin do
    root "home#index"
    resources :colleges
    resources :teachers
    resources :companies
    resources :recruitments
    resources :categories
    resources :courses do
      resources :sub_courses
    end
  end
  #微信平台培训报名
  namespace :wechat do
    root "applies#home"
    get 'applies/error', as: 'error'
    resources :applies do
      collection do
        get :home
      end
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
