class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def sign_in(user)
    session[:user_id] = user.id
  end

  def user_signed_in?
    session[:user_id].present?
  end
  helper_method :user_signed_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if user_signed_in?
  end
  helper_method :current_user

  def authenticate_user
    redirect_to new_session_path, notice: "Please sign in." unless user_signed_in?
  end

  def authorized_count(code_snippets)
    new_code_snippets = []
    code_snippets.each do |snippet|
      new_code_snippets << snippet if can? :read, snippet
    end
    @code_snippets = Kaminari.paginate_array(new_code_snippets).page(params[:page]).per(5)
  end
end
