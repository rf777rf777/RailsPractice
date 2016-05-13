Rails.application.routes.draw do
  
    #使用Restful
    resources :events do
    
    #Restful 綜合應用實作
    #一對多
    resources :attendees , controller: "event_attendees"
    
    #一對一(所以使用單數resource)
    #Controller檔名還是複數( "event_locations" )
    #使用RESTful路由的Controller 無論在config/routes.rb中使用單數resource或複數resources形式
    #檔名一律都是複數
    resource :location, controller: "event_locations"

    #新增不同的頁面
    #collection 表示這一個路由是針對 events 集合來操作
    collection do
        get :latest
    end

    #一次刪除多筆資料 
    #RESTful中的destroy action是用來刪除一筆資料的
    collection do
      post :bulk_delete
    end

    collection do
      post :bulk_update
    end

    #新增event dashboard 頁面
    #member 表示這一個路由是針對特定一個 event 來操作
    #必須傳入某一個 event
    member do
      get :dashboard
    end

    #自訂member路由
    member do
      post :join
      post :withdraw
    end

  end

  resources :people #此為建立應架(scaffold)時自動產生

  #瀏覽器 GET "/welcome/say_hello" 就會送到welcome controller的say action
  get "/welcome/say_hello" => "welcome#say" 
  
  #預設首頁直接送到welcome controller的index action
  root "welcome#index"

  get "/welcome" => "welcome#index"
  
  #使用外卡路由
  #match ':controller(/:action(/:id(.:format)))', :via => :all




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
