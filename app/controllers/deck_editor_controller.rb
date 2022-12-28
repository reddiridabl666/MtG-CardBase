# frozen_string_literal: true

# controller for deck editing
class DeckEditorController < ApplicationController
  before_action :init_deck
  before_action :redirect_if_not_logged_in

  add_flash_types :deck_alert

  def show_deck; end

  def save_deck
    session[:is_deckbuilding] = false

    @deck&.name = params[:deck_name]
    @deck&.format = Format.find_by_id(params[:deck_format])
    @deck&.save
    session[:deck_id] = nil

    redirect_to show_deck_path(deck_id: @deck&.id)
  end

  def delete_deck
    session[:is_deckbuilding] = false
    @deck&.destroy
    session[:deck_id] = nil

    render 'hide_deck'
  end

  def create_deck
    return redirect_to root_path, alert: I18n.t('inv-format') if Format.find_by_id(params[:deck_format]).blank?

    @deck = Deck.create(name: params[:deck_name], format: Format.find_by_id(params[:deck_format]),
                        user_id: current_user&.id)

    return redirect_to root_path, alert: I18n.t('same-deck') unless @deck.valid?

    start_deckbuilding

    render 'refresh_deck'
  end

  def add_card
    return redirect_back(fallback_location: root_path) unless @deck.present?

    card_instance = CardInstance.find_by_uuid(params[:card_uuid])
    return if card_instance.blank?

    if CardInDeck.total_same(@deck, card_instance.card) > @deck.format.max_same - 1 &&
       card_instance.card.supertypes.exclude?('Basic')
      return redirect_back(fallback_location: root_path,
                           deck_alert: I18n.t('max-same-exceed', max: @deck.format.max_same))
    end

    @deck.add_card(card_instance)

    render 'refresh_deck'
  end

  def remove_card
    return redirect_back(fallback_location: root_path) unless @deck.present?

    card_in_deck = @deck.cards.find_by(id: params[:card_id])
    return if card_in_deck.blank?

    CardInDeck.remove(card_in_deck)

    render 'refresh_deck'
  end

  private

  def start_deckbuilding
    session[:is_deckbuilding] = true
    session[:deck_id] = @deck.id
  end
end
