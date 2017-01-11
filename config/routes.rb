Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  get '/history', to: 'home#history'
  get '/log',     to: 'home#log'

  resource :games do
    collection do
      get :history
    end
  end
end
