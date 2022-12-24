class MainController < ApplicationController
  before_action :init_deck
  before_action :page, :init_meta_info, only: [:index, :filtered]
  before_action :init_params, only: [:filtered]
  before_action :base_params, only: [:index]
  before_action :redirect_if_not_logged_in, except: [:index, :filtered]

  def index
    @cards = CardInstance.filtered(@params).page @page
  end

  def filtered
    @show_filters = true
    @cards = CardInstance.filtered(@params).page @page
    render 'index'
  end

  def deck_format; end

  def create_deck
    redirect_to root_path, alert: 'Invalid deck format' if Format.find_by_id(params[:deck_format]).blank?

    session[:is_deckbuilding] = true
    @deck = Deck.create!(name: params[:deck_name], format: Format.find_by_id(params[:deck_format]), user_id: current_user&.id)

    session[:deck_id] = @deck.id
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

  def add_card
    return redirect_back(fallback_location: root_path) unless @deck.present?

    @card = CardInstance.find_by_uuid(params[:card_uuid])

    if CardInDeck.total_same(@deck, @card.card) > @deck.format.max_same - 1 && @card.card.supertypes.exclude?('Basic')
      return redirect_back(fallback_location: root_path, alert: "Can't add more than #{@deck.format.max_same} of the same card")
    end

    @card_in_deck = @deck.cards.find_by(card_instance_id: @card.id)
    if @card_in_deck.present?
      @card_in_deck.num += 1
      @card_in_deck.save
    else
      CardInDeck.create(deck_id: @deck.id, card_instance_id: @card.id)
    end
  end

  private

  def page
    @page = params[:page].present? ? params[:page] : 1
    @page = [CardInstance.page.total_pages, @page.to_i].min
  end

  def init_meta_info
    @expansions = [''] + Expansion.all
    @supertypes = [''] + CardType.where(type_scope: :super).to_a
    @types = [''] + CardType.where(type_scope: :normal).to_a
    @subtypes = [''] + CardType.where(type_scope: :sub).to_a
  end

  def init_params
    @params = params
  end

  def base_params
    @params = { color_w: 1, color_b: 1, color_u: 1, color_r: 1, color_g: 1, color_c: 1 }
  end

  def redirect_if_not_logged_in
    redirect_to root_path unless current_user.present?
  end

  def init_deck
    return @deck = nil if session[:deck_id].blank?
    @deck ||= Deck.find_by_id(session[:deck_id])
  end
end
