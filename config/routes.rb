Rails.application.routes.draw do
  resources :utm_tags
  resources :domains
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  scope [:api, :v1], defaults: {format: :json} do
    devise_for :users, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
               controllers: {
                 sessions: 'api/v1/users/sessions',
                 registrations: 'api/v1/users/registrations',
                 passwords: 'api/v1/users/passwords',
                 confirmations: 'api/v1/users/confirmations'
               }
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: :show
      resources :statistics, only: :index
      resources :domains
      resource :account
      resources :subscribe_pages do
        resources :utm_tags
        resources :logins do
          get :report, on: :collection
        end
      end
      resource :user_info do
        post :set_locale
      end
      # resources :subscribe_pages, only: [:index, :edit, :create, :update, :destroy, :new] do
      #   post :check_user_name, on: :collection
      # end
    end
  end

  get "/pages/*url/check_login_follow", :controller => 'pages', :action => 'check_login_follow'
  get "/pages/*url/success", :controller => 'pages', :action => 'success'
  get "/pages/*url/welcome", :controller => 'pages', :action => 'welcome'
  get "/pages/*url/enter_login", :controller => 'pages', :action => 'enter_login'
  get "/pages/*url/check", :controller => 'pages', :action => 'check'
  get "/pages/*url/get_bonus", :controller => 'pages', :action => 'get_bonus'
  get "/pages/*url", :controller => 'pages', :action => 'show'
  post "/pages/*url", :controller => 'pages', :action => 'create'
end
