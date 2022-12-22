class MainController < ApplicationController
  before_action :redirect_if_not_logged_in, only: [:create_deck, :deck_format]

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

    @params = params
    render 'index'
  end

  def deck_format; end

  def create_deck
    redirect_to root_path, alert: 'Invalid decks format' if Format.find_by_id(params[:deck_format]).blank?

    session[:is_deckbuilding] = true
    @deck = Deck.new(format: Format.find_by_id(params[:deck_format]), user_id: current_user&.id)

    raise 'DECK ERROR' unless @deck.valid?

    session[:deck] = @deck
  end
end
