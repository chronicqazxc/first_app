module SessionsHelper
  def sign_in(user)
    session[:session_token] = user.session_token
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user
    @curren_user ||= User.find_by_session_token(session[:session_token])
  end
  
  def current_user?(user)
    current_user == user
  end
  
  # Log out
  def sign_out
    @current_user = nil
    session.delete(:session_token)
  end
  
  def authenticate_user
    unless signed_in? # No login
      flash[:warning] = "Sign in to continue"
      redirect_to new_session_path
    end
  end
end
