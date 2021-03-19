MatchmakerRails::Application.routes.draw do
  namespace :api, defaults: { format: "json" } do
    resource :health_check, only: :show
  end

  root "tasks#index"

  get "/tasks", to: "tasks#index"
  get "/tasks/:id", to: "tasks#show"
end
