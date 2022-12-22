class DeckBuildingController < ApplicationController
  def index
    @params = params
    @show_filters = true
    @cards = CardInstance.filtered(@params).page @page
  end

  def add_card

  end

  def save
    session[:is_deckbuilding] = false
    @deck&.save
  end

  def delete
    session[:is_deckbuilding] = false
    @deck&.destroy
  end
end
