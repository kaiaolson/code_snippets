class CodeSnippetsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]
  before_action :find_user_code_snippet, only: [:update, :destroy]

  def index
    case
    when params[:q]
      session[:q] = params[:q]
      code_snippets = CodeSnippet.search(session[:q])
    when params[:filter]
      code_snippets = CodeSnippet.where(language: params[:filter])
    when params[:user_snippets]
      code_snippets = CodeSnippet.where(user_id: current_user.id)
    else
      code_snippets = CodeSnippet.all
    end
    authorized_count(code_snippets)
  end

  def show
    find_code_snippet
  end

  def new
    @code_snippet = CodeSnippet.new
  end

  def create
    @code_snippet = CodeSnippet.new code_snippet_params
    @code_snippet.user = current_user
    if @code_snippet.save
      redirect_to @code_snippet, notice: "Code snippet was successfully created."
    else
      render :new
      flash[:alert] = "Code snippet was not created!"
    end
  end

  def edit
    find_code_snippet
  end

  def update
    if @user_code_snippet.update code_snippet_params
      redirect_to @user_code_snippet, notice: "Code snippet was successfully updated."
    else
      render :edit
      flash[:alert] = "Code snippet not updated!"
    end
  end

  def destroy
    @user_code_snippet.destroy
    redirect_to code_snippets_url, notice: "Code snippet was successfully destroyed."
  end

  private

  def find_code_snippet
    @code_snippet = CodeSnippet.find params[:id]
  end

  def code_snippet_params
    params.require(:code_snippet).permit(:title, :body, :privacy, :language_id, :user_id)
  end

  def find_user_code_snippet
    @user_code_snippet ||= current_user.code_snippets.find(params[:id])
  end
end
