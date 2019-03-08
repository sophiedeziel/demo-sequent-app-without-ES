class ApplicationController < ActionController::Base
  helper_method :notifications
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(session: session[:user_session])
  end

  def notifications
    @notifications ||= Notification.where(user: current_user, read_at: nil)
  end
end
