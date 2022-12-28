# frozen_string_literal: true

# sessions controller
class SessionController < ApplicationController
  def login; end

  def authorize
    user = User.find_by_name(params[:name])
    return redirect_to_login unless user&.authenticate params[:password]

    session[:current_user_id] = user.id
    redirect_to root_path
  end

  def logout
    reset_session
    redirect_to root_path
  end

  private

  def redirect_to_login
    redirect_to login_path, flash: { alert: I18n.t('invalid_creds') }
  end
end
