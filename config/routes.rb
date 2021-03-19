MatchmakerRails::Application.routes.draw do
  namespace :api, defaults: { format: "json" } do
    resource :health_check, only: :show
  end
  end
