Rails.application.routes.draw do
  resources :expansions
  resources :card_instances
  resources :cards
  get 'main/add_card'
  get 'main/create_deck'
  get 'main/show_card'
  get 'decks', to: "main#decks"

  get 'logout', to: "session#logout"
  get 'login', to: "session#login"
  get 'signup', to: "users#new"

  post 'authorize', to: "session#authorize"

  get 'set/:code', to: "main#by_set"

  resources :users
  root "main#index"
end
