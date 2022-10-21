Rails.application.routes.draw do
  # resources :recipes
  # resources :users

  #route to allow a logged in user see all recipes and their individual users
  get "/recipes", to: "recipes#index"

  #LOGIN
  post "/login", to: "sessions#create"

  #auto login
  get "/me", to: "users#show"

  #LOGOUT
  delete "/logout", to: "sessions#destroy"

  #route to allow a logged in user to create a recipe and save to db
  post "/recipes", to: "recipes#create"

  #route to allow users to signup
  post "/signup", to: "users#create"
end
