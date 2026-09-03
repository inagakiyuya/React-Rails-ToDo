Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # ログインURLの追加（AuthenticationController用）
  post 'auth/login', to: 'authentication#login'

  # Api::V1 の名前空間に合わせ、かつ user に posts をネストさせる
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create] do
        resources :posts # これで /api/v1/users/:user_id/posts というURLになります
      end
    end
  end
end
