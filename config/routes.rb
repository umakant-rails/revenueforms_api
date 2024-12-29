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
    end
  end
end
