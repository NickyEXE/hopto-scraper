Rails.application.routes.draw do
  get "/beers", to: "beers#beers"
  get "/drafts", to: "beers#drafts"
  get "/cans", to: "beers#cans"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
