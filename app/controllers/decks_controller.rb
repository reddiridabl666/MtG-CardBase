class DecksController < ApplicationController
  before_action :init_deck, only: [:edit]
  before_action :redirect_if_no_deck, :redirect_if_not_logged_in, except: [:decks]

  def decks
    @page = page(Deck)
    @decks = Deck.by_user(params[:user_name]).page @page
  end

  def show
    @deck = Deck.find_by(id: params[:deck_id])
    redirect_to root_path if @deck.blank?
  end

  def copy
    original = Deck.find_by(id: params[:deck_id])
    copy = Deck.copy(original, current_user)
    redirect_to show_deck_path(deck_id: copy.id)
  end

  def delete
    @deck = Deck.find_by(id: params[:deck_id])
    @deck&.destroy
    redirect_to decks_path(user_id: current_user&.id)
  end

  def edit
    @deck&.save

    session[:is_deckbuilding] = true
    session[:deck_id] = params[:deck_id]

    redirect_to root_path
  end

  private

  def redirect_if_no_deck
    redirect_back(fallback_location: decks_path) if params[:deck_id].blank?
  end
end
