class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def login!(user)
    session[:session_token] = user.session_token
  end

  def logout!
    current_user.update(session_token: User.generate_unique_token)
    session[:session_token] = nil
  end

  def current_user
    @current_user ||= session[:session_token] &&
        User.find_by(session_token: session[:session_token])
  end

  def flash_store(model_obj)
    flash[:errors] = model_obj.errors.full_messages
  end

  def flash_now_store(model_obj)
    flash.now[:errors] = model_obj.errors.full_messages
  end
end
