class ApplicationController < ActionController::Base
  before_action :page, :init_meta_info

  def user_authenticated
    return false if session[:current_user_id].nil?
    true
  end

  def current_user
    return nil unless user_authenticated

    @current_user ||= User.find_by_id(session[:current_user_id])
  end

  def allow_only_admin
    redirect_back(fallback_location: root_path) unless current_user&.is_admin
  end

  helper_method :current_user, :user_authenticated

  protected

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

  def redirect_if_not_logged_in
    redirect_to root_path unless current_user.present?
  end
end
