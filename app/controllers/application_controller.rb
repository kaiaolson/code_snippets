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

  def current_user
    @current_user ||= User.find(session[:user_id]) if user_signed_in?
  end

  def authenticate_user
    redirect_to new_session_path, notice: "Please sign in." unless user_signed_in?
  end

  # called after the case/when statement in code_snippets#index
  # filters the array of code snippets to return only those records that the
  # user can read (accounts for records that are checked "private")
  # putting it in the application controller and calling it between the controller
  # and the view also allows for an accurate count on the view page
  def authorized_count(code_snippets)
    new_code_snippets = []
    code_snippets.each do |snippet|
      new_code_snippets << snippet if can? :read, snippet
    end
    @code_snippets = Kaminari.paginate_array(new_code_snippets).page(params[:page]).per(5)
  end

  # helper methods
  helper_method :user_signed_in?
  helper_method :current_user

end
