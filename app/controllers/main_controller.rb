class MainController < ApplicationController
  before_action :page
  def index
    @cards = CardInstance.all.page @page
  end

  private

  def page
    @page = params[:page].present? ? params[:page] : 1
    @page = [CardInstance.page.total_pages, @page.to_i].min
  end
end
