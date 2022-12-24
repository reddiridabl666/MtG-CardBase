Rails.application.routes.draw do
  get 'decks', to: "main#decks"

  get 'logout', to: "session#logout"
  get 'login', to: "session#login"
  get 'signup', to: "users#new"

  post 'authorize', to: "session#authorize"

  get 'filtered', to: "main#filtered"

  get 'deck_building', to: "main#deck_building"

  post 'create_deck', to: "main#create_deck"
  patch 'save_deck', to: "main#save_deck"
  delete 'delete_deck', to: "main#delete_deck"
  patch 'add_card', to: "main#add_card"

  get 'deck_format', to: "main#deck_format", format: 'turbo_stream'

  resources :users
  root "main#index"
end
