MatchmakerRails::Application.routes.draw do
  namespace :api, defaults: { format: "json" } do
    resource :health_check, only: :show
  end

  root "tasks#index"

  resources :tasks do
    collection do
      post :start
      post :stop
    end
  end
  resources :agents
end
