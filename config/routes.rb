Rails.application.routes.draw do
  
  scope(:path => '/api') do
    devise_for :users, path: 'users', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup',
    }, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords',
      confirmations: 'users/confirmations'
    }

    post '/log_visit', to: 'traffic_logs#log_visit'
    get '/traffic_logs', to: 'traffic_logs#show'

    namespace :admin, path: :admin do
      resources :dashboards, only: [:index] do 
        get '/visited_pages' => "dashboards#visited_pages", as: :visited_pages, on: :collection
        get '/visited_users' => "dashboards#visited_users", as: :visited_users, on: :collection
      end
      resources :users, only: [:index, :show, :destroy]
      resources :requests, only: [:index, :show]
      resources :blog_subjects do
        get '/get_subjects' => "blog_subjects#get_subjects", as: :get_subjects, on: :collection
      end
      resources :blog_posts
      resources :contact_msgs, only: [:index, :show, :destroy]
    end

    resources :requests do
      resources :participants do 
        post '/mark_applicant' => "participants#mark_applicant", as: :mark_applicant, on: :member
        get '/get_participant_types' => "participants#get_participant_types", as: :get_participant_types, on: :collection
      end
      resources :khasras do
        get '/get_khasra_data' => "khasras#get_khasra_data", as: :get_khasra_data, on: :collection
      end
      resources :khasra_battanks do
        get '/get_khasra_batank_data' => "khasra_battanks#get_khasra_batank_data", as: :khasra_batank_data, on: :collection
        post '/allote_khasra_to_hissedar' => "khasra_battanks#allote_khasra_to_hissedar", as: :allote_khasra_to_hissedar, on: :collection
        post '/revoke_khasra_of_hissedar' => "khasra_battanks#revoke_khasra_of_hissedar", as: :revoke_khasra_of_hissedar, on: :collection
      end

      get '/edit' => "requests#edit", as: :edit, on: :member
      get '/pending' => "requests#pending_request", as: :pending_request, on: :collection
      get '/request_detail' => "requests#request_detail", as: :request_detail, on: :member
      get '/batwara_detail' => "requests#batwara_detail", as: :batwara_detail, on: :member
    end
    resources :request_types, only: [:index]
    resources :contact_msgs, only: [:create]

    namespace :public, path: :pb do
      resources :form_sections do 
        get '/get_categories' => "form_sections#get_categories", as: :get_categories, on: :member 
      end

      resources :form_categories do 
        get '/get_forms' => "form_categories#get_forms", as: :get_forms, on: :member 
      end

      resources :blank_forms do
        get "/get_districts" => "blank_forms#get_districts", as: :get_districts, on: :collection
        get "/district/:district_id/get_tehsils" => "blank_forms#get_tehsils", as: :get_tehsils, on: :collection
        get "/tehsils/:tehsil_id/get_villages" => "blank_forms#get_villages", as: :get_villages, on: :collection
      end

      resources :blog_posts
    end
  end
end
