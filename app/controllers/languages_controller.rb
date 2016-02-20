class LanguagesController < ApplicationController
  def new
    @language = Language.new
  end

  def create
    language_params = params.require(:language).permit(:name)
    @language = Language.new language_params
    if @language.save
      redirect_to new_code_snippet_path, notice: "Language added!"
    else
      render :new, alert: "Language not added!"
    end
  end
end
