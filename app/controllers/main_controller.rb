class MainController < ApplicationController
  before_action :page
  def index
    @cards = CardInstance.all.page @page
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

  def parse_params
    @cards = CardInstance.all
    @cards = @cards.where(expansion_id: Expansion.find_by_code(params[:set])) if params[:set].present?

    @cards = @cards.where("power >= ?", params[:power_ge]).or(@cards.where(:power, ['X', '*', nil])) if params[:power_ge].present?
    @cards = @cards.where("power <= ?", params[:power_le]).or(@cards.where(:power, ['X', '*', nil])) if params[:power_le].present?

    @cards = @cards.where("toughness >= ?", params[:toughness_ge]).or(@cards.where(:toughness, ['X', '*', nil])) if params[:toughness_ge].present?
    @cards = @cards.where("OR toughness <= ?", params[:toughness_le]).or(@cards.where(:toughness, ['X', '*', nil])) if params[:toughness_le].present?

    @cards = @cards.where("mana_value >= ?", params[:cost_ge]) if params[:cost_ge].present?
    @cards = @cards.where("mana_value <= ?", params[:cost_le]) if params[:cost_le].present?
  end
end
