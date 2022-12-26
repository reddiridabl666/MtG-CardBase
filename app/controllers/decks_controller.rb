class DecksController < ApplicationController
  before_action :init_deck
  before_action :redirect_if_not_logged_in

  add_flash_types :deck_alert

  def show_deck
  end

  def save_deck
    session[:is_deckbuilding] = false
    @deck&.save
    session[:deck_id] = nil
  end

  def delete_deck
    session[:is_deckbuilding] = false
    @deck&.destroy
    session[:deck_id] = nil
  end

  def create_deck
    return redirect_to root_path, alert: 'Invalid deck format' if Format.find_by_id(params[:deck_format]).blank?

    @deck = Deck.create(name: params[:deck_name], format: Format.find_by_id(params[:deck_format]), user_id: current_user&.id)

    unless @deck.valid?
      return redirect_to root_path, alert: 'You already have a deck with such name'
    end

    session[:is_deckbuilding] = true
    session[:deck_id] = @deck.id

    render 'refresh_deck'
  end

  def add_card
    return redirect_back(fallback_location: root_path) unless @deck.present?

    card_instance = CardInstance.find_by_uuid(params[:card_uuid])
    return if card_instance.blank?

    if CardInDeck.total_same(@deck, card_instance.card) > @deck.format.max_same - 1 && card_instance.card.supertypes.exclude?('Basic')
      return redirect_back(fallback_location: root_path, deck_alert: "Can't add more than #{@deck.format.max_same} of the same card")
    end

    card_in_deck = @deck.cards.find_by(card_instance_id: card_instance.id)
    if card_in_deck.present?
      card_in_deck.num += 1
      card_in_deck.save
    else
      CardInDeck.create(deck_id: @deck.id, card_instance_id: card_instance.id)
    end

    render 'refresh_deck'
  end

  def remove_card
    return redirect_back(fallback_location: root_path) unless @deck.present?

    card_in_deck = @deck.cards.find_by(id: params[:card_id])
    return if card_in_deck.blank?

    if card_in_deck.num - 1 == 0
      card_in_deck.destroy
    else
      card_in_deck.num -= 1
      card_in_deck.save
    end

    render 'refresh_deck'
  end

  private

  def init_deck
    return @deck = nil if session[:deck_id].blank?
    @deck ||= Deck.find_by_id(session[:deck_id])
  end
end
