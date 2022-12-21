class MainController < ApplicationController
  before_action :page
  def index
    @cards = CardInstance.filtered(params).page @page
    @expansions = [''] + Expansion.all
    @supertypes = [''] + CardType.where(type_scope: :super).to_a
    @types = [''] + CardType.where(type_scope: :normal).to_a
    @subtypes = [''] + CardType.where(type_scope: :sub).to_a
  end

  def by_set
    return redirect_to root_path if params[:code].blank?
    expansion = Expansion.find_by_code(params[:code])

    return redirect_to root_path if expansion.nil?
    @cards = CardInstance.where(expansion_id: expansion.id).page @page

    render 'index'
  end

  private

  def page
    @page = params[:page].present? ? params[:page] : 1
    @page = [CardInstance.page.total_pages, @page.to_i].min
  end

  # def filtered_cards(params)
  #   cards = CardInstance.all
  #   cards = CardInstance.filter_by_expansion(cards, params[:set])
  #
  #   cards = CardInstance.filter_by_mana(cards, params[:cost_ge], params[:cost_le])
  #   cards = CardInstance.filter_by_power(cards, params[:cost_ge], params[:cost_le])
  #
  #   cards = CardInstance.filter_by_toughness(cards, params[:cost_ge], params[:cost_le])
  #   cards = CardInstance.filter_by_types(cards, params[:types], params[:subtypes], params[:supertypes])
  #
  #   cards
  # end
end
