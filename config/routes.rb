Rails.application.routes.draw do
  get 'decks', to: "main#decks"
  get 'show_deck', to: "decks#show_deck"

  get 'logout', to: "session#logout"
  get 'login', to: "session#login"
  get 'signup', to: "users#new"

  post 'authorize', to: "session#authorize"

  get 'filtered', to: "main#filtered"

  post 'create_deck', to: "decks#create_deck"
  patch 'save_deck', to: "decks#save_deck"
  delete 'delete_deck', to: "decks#delete_deck"

  patch 'add_card', to: "decks#add_card"
  patch 'remove_card', to: "decks#remove_card"

  get 'deck_format', to: "main#deck_format", format: 'turbo_stream'

  resources :users
  root "main#index"
end
