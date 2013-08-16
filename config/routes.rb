StartBarter::Application.routes.draw do
  
  resources :jobs
  resources :appliedjobs
  match '/rate' => 'rater#create', :as => 'rate'

  match '/about_us', :to => "static_pages#about_us"
  match '/services', :to => "static_pages#services"
  match '/contact_us', :to => "static_pages#contact_us"
  match '/about_company', :to => "static_pages#about_company"
  match '/our_vision', :to => "static_pages#our_vision"
  match '/our_mission', :to => "static_pages#our_mission"
  match "profile", :to  => "home#profile", :as => :index
  match "profile_pic_upload" => "home#profile_pic_upload"
  match "new_profile" => "home#new_profile"
  match '/edit_user_info' => "home#edit_user_info"
  match '/update_user_info' => "home#update_user_info"
  match '/add_experience' => "home#add_experience"
  match '/experience_delete/:id' => "home#experience_delete"
  match 'add_skill' => "home#add_skill"
  match '/skill_delete/:id' => "home#skill_delete"
  match '/add_education' => "home#add_education"
  match '/education_delete/:id' => "home#education_delete"
  match '/edit_skill/:id' => "home#edit_skill"
  match '/show_profile/:id' => "home#show_profile"
  match 'search' => 'home#search', :via => [:get, :post], :as => :search
  match '/jobs/select_subcategory/:id' => 'jobs#select_subcategory'
  match '/home/user_profile' => 'home#user_profile'
  match '/applied_to_job' => 'appliedjobs#applied_to_job'
  match '/people_applied_for_job' => 'jobs#people_applied_for_job'
  
  devise_for :users,
      :controllers => { 
      :sessions           => 'devise/sessions', 
      :registrations      => 'devise/registrations', 
      :confirmations      => 'devise/confirmations', 
      :passwords          => 'devise/passwords',
      :omniauth_callbacks => 'users/omniauth_callbacks'
      },
      :path => '',
      :path_names => {:sign_in => 'users/sign_in', :sign_out => 'users/sign_out', :sign_up => 'users/sign_up'}
   
    resources :users 
    resources :experiences
    root :to => 'home#index'

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
