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
end
