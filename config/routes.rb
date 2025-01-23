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

    namespace :admin, path: :admin do
      resources :blog_subjects do
        get '/get_subjects' => "blog_subjects#get_subjects", as: :get_subjects, on: :collection
      end
      resources :blog_posts
    end

    resources :requests do
      resources :participants do 
        post '/mark_applicant' => "participants#mark_applicant", as: :mark_applicant, on: :member
      end
      resources :khasras do
        get '/get_khasra_data' => "khasras#get_khasra_data", as: :get_khasra_data, on: :collection
      end
      get '/pending' => "requests#pending_request", as: :pending_request, on: :collection
      get 'request_detail' => "requests#request_detail", as: :request_detail, on: :member
    end
    resources :request_types, only: [:index]

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
