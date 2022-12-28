# frozen_string_literal: true

# main controller
class MainController < ApplicationController
  before_action :init_deck, :show_filters_init

  before_action :init_meta_info, only: %i[index filtered]
  before_action :init_params, only: [:filtered]
  before_action :base_params, only: [:index]
  before_action :redirect_if_not_logged_in, only: [:deck_format]

  layout 'clear'

  def index
    @page = page(CardInstance)
    @cards = CardInstance.filtered(@params).page @page
  end

  def filtered
    @page = page(CardInstance)
    @cards = CardInstance.filtered(@params).page @page
    render 'index'
  end

  def toggle_filters
    session[:show_filters] = !@show_filters
    head :ok
  end

  def deck_format; end

  private

  def init_meta_info
    @expansions = [''] + Expansion.all
    @supertypes = [''] + CardType.where(type_scope: :super).to_a
    @types = [''] + CardType.where(type_scope: :normal).to_a
    @subtypes = [''] + CardType.where(type_scope: :sub).to_a
  end

  def show_filters_init
    @show_filters = session[:show_filters]
  end

  def init_params
    @params = params
  end

  def base_params
    @params = { color_w: 1, color_b: 1, color_u: 1, color_r: 1, color_g: 1, color_c: 1 }
  end
end
