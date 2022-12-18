class MainController < ApplicationController
  def index
    @cards = CardInstance.all
  end
end
