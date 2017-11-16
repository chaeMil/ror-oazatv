module Admin
  class LanguagesController < AdminController
    before_action :set_language, only: [:show, :edit, :update, :destroy]

    def index
      @languages = Language.all
    end

    def new
      @language = Language.new
    end

    def create
      @language = Language.new(language_params)
      if @language.save!
        redirect_to admin_language_path(@language), notice: 'Language was successfully created'
      else
        render :new
      end
    end

    def update
      if @language.update(language_params)
        redirect_to admin_language_path(@language), notice: 'Language was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @language.destroy
      redirect_to admin_languages_path, notice: 'Language was successfully destroyed.'
    end

    private
    def set_language
      @language = Language.find(params[:id])
    end

    def language_params
      params.require(:language).permit(:title, :locale)
    end
  end
end
