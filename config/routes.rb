Rails.application.routes.draw do
  get 'decks', to: "main#decks"

  get 'logout', to: "session#logout"
  get 'login', to: "session#login"
  get 'signup', to: "users#new"

  post 'authorize', to: "session#authorize"

  get 'set/:code', to: "main#by_set"
  get 'filtered', to: "main#filtered"

  get 'create_deck', to: "main#create_deck"
  post 'save_deck', to: "main#save_deck", format: 'turbo_stream'
  post 'delete_deck', to: "main#delete_deck", format: 'turbo_stream'
  post 'add_card', to: "main#add_card", format: 'turbo_stream'

  post 'deck_format', to: "main#deck_format", format: 'turbo_stream'

  resources :users
  root "main#index"
end
