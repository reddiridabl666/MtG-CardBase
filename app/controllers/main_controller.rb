class MainController < ApplicationController
  before_action :page, :init_meta_info, only: [:index, :filtered, :by_set, :create_deck]
  before_action :init_params, only: [:filtered, :by_set, :create_deck]
  before_action :redirect_if_not_logged_in, only: [:create_deck, :deck_format, :add_card]

  def index
    @params = { color_w: 1, color_b: 1, color_u: 1, color_r: 1, color_g: 1, color_c: 1 }
    @cards = CardInstance.filtered(@params).page @page
  end

  def filtered
    @params = params
    @show_filters = true
    @cards = CardInstance.filtered(@params).page @page
    render 'index'
  end

  def by_set
    return redirect_to root_path if params[:code].blank?
    expansion = Expansion.find_by_code(params[:code])

    return redirect_to root_path if expansion.nil?
    @cards = CardInstance.where(expansion_id: expansion.id).page @page

    render 'index'
  end

  def deck_format; end

  def create_deck
    redirect_to root_path, alert: 'Invalid decks format' if Format.find_by_id(params[:deck_format]).blank?

    @cards = CardInstance.filtered(@params).page @page

    session[:is_deckbuilding] = true
    @deck = Deck.new(format: Format.find_by_id(params[:deck_format]), user_id: current_user&.id)

    raise 'DECK ERROR' unless @deck.valid?

    session[:deck] = @deck
    render 'index'
  end

  def save_deck
    session[:is_deckbuilding] = false
    @deck&.save
  end

  def delete_deck
    session[:is_deckbuilding] = false
    @deck&.destroy
  end

  def add_card

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

  # def find_deck
  #   @deck = Deck.find_by_id(session[:deck_id])
  # end

  def redirect_if_not_logged_in
    redirect_to root_path unless current_user.present?
  end
end
