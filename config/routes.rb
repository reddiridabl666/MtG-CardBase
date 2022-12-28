Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ru/ do
    root "main#index"

    get 'decks', to: "decks#decks"
    get 'show_deck', to: "decks#show"
    get 'edit_deck', to: "decks#edit"
    post 'copy_deck', to: "decks#copy"
    delete 'delete_deck', to: "decks#delete"

    get 'logout', to: "session#logout"
    get 'login', to: "session#login"
    get 'signup', to: "users#new"

    post 'authorize', to: "session#authorize"

    get 'filtered', to: "main#filtered"

    post 'create_deck', to: "deck_editor#create_deck"
    patch 'save_deck', to: "deck_editor#save_deck"
    delete 'delete_current_deck', to: "deck_editor#delete_deck"

    patch 'add_card', to: "deck_editor#add_card"
    patch 'remove_card', to: "deck_editor#remove_card"

    get 'deck_format', to: "main#deck_format", format: 'turbo_stream'

    resources :users
  end
end
