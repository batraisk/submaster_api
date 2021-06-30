Rails.application.routes.draw do
  scope [:api, :v1], defaults: {format: :json} do
    devise_for :users, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
               controllers: {
                 sessions: 'api/v1/users/sessions',
                 registrations: 'api/v1/users/registrations',
                 passwords: 'api/v1/users/passwords'
               }
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: :show
    end
  end
end
