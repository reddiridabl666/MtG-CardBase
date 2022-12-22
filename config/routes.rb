Rails.application.routes.draw do
  get 'decks', to: "main#decks"

  get 'logout', to: "session#logout"
  get 'login', to: "session#login"
  get 'signup', to: "users#new"

  post 'authorize', to: "session#authorize"

  get 'set/:code', to: "main#by_set"
  get 'filtered', to: "main#filtered"

  get 'deck', to: "deck_building#index"
  post 'save_deck', to: "deck_building#save_deck", format: 'turbo_stream'
  post 'delete_deck', to: "deck_building#delete_deck", format: 'turbo_stream'
  post 'add_card', to: "deck_building#add_card", format: 'turbo_stream'

  post 'deck_format', to: "main#deck_format", format: 'turbo_stream'

  resources :users
  root "main#index"
end
