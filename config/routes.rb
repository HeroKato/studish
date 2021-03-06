Rails.application.routes.draw do
  
  root 'welcome#index'
  get 'welcome/contact'
  
  get 'statics/privacy'
  get 'statics/terms'

  get 'password_resets/new'
  get 'password_resets/edit'
  
  # お問い合わせフォーム
  get  'inquiry', to: 'inquiry#index'
  post 'inquiry/confirm', to: 'inquiry#confirm'
  post 'inquiry/thanks', to: 'inquiry#thanks'
  
  # ログイン/ログアウト
  get    'login' , to: 'sessions#new'
  post   'login' , to: 'sessions#create'
  delete 'logout' , to: 'sessions#destroy'
  
  # 新規登録
  # get 'signup', to: 'coaches#new'
  get '/signup', to: 'users#new'
  
  #resources :coaches
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  
  #namespace :admin do
  #  get 'top/index'
  #end
  
  #namespace :admin do
  #  root to: "top#index"
  #  resources :coaches do
  #    collection { get "search" }
  #  end
  #end
  
  #resources :coaches do
  #  get :favorites, on: :member
  #end
  
  #resources :students
  #resources :students do
  #  resources :posts
  #  resources :post_pictures
  #  resources :post_comments
  #  resources :post_comment_pictures
  #  get :favorites, on: :member
  #  get :answers, on: :member
  #  get :notifications, on: :member
  #  get :account, on: :member
  #end
  
  resources :favorites, only: [:create]
  resources :accounts, only: [:show, :edit, :update]
  
  resources :users
  resources :users do
    get :favorites, on: :member
    get :answers, on: :member
    get :notifications, on: :member
    resources :posts do
      resources :favorites, only: [:create, :destroy]
    end
    resources :post_comments do
      resources :favorites, only: [:create, :destroy]
    end
  end
  
  resources :posts
  resources :posts do
    resources :post_pictures
    resources :post_comments
  end
  
  resources :post_comments
  resources :post_comments do
    resources :post_comment_pictures
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
