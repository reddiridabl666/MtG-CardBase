Rails.application.routes.draw do
  get 'decks', to: "main#decks"

  get 'logout', to: "session#logout"
  get 'login', to: "session#login"
  get 'signup', to: "users#new"

  post 'authorize', to: "session#authorize"

  get 'set/:code', to: "main#by_set"
  get 'filtered', to: "main#filtered"

  post 'create_deck', to: "main#create_deck"
  post 'save_deck', to: "main#save_deck"
  post 'delete_deck', to: "main#delete_deck"
  post 'add_card', to: "main#add_card"

  post 'deck_format', to: "main#deck_format"

  resources :users
  root "main#index"
end
