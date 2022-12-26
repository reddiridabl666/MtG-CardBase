class ApplicationController < ActionController::Base
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

  def redirect_if_not_logged_in
    redirect_to root_path unless current_user.present?
  end

  def init_deck
    return @deck = nil if session[:deck_id].blank?
    @deck ||= Deck.find_by_id(session[:deck_id])
  end
end
