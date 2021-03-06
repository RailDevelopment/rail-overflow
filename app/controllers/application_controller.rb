class ApplicationController < ActionController::Base
  before_action :set_raven_context
  protect_from_forgery
  helper_method :current_user

  def current_user
    # Note: we want to use "find_by_id" because it's OK to return a nil.
    # If we were to use User.find, it would throw an exception if the user can't be found.
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def authenticate_user
    if current_user.nil?
      flash[:error] = 'Please sign in to do that.'
      redirect_to :sign_in
    end
  end

  private
  def set_raven_context
    Raven.user_context(id: session[:user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
