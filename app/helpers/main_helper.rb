module MainHelper
  def user_is_deckbuilding
    false if session[:is_deckbuilding].blank?
    session[:is_deckbuilding]
  end
end
