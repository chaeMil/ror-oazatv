class Api::V3::LanguagesController < ApplicationController

  #GET /languages
  def index
    page = params[:page] || 1
    @page = page
    @languages = Language.page(page)
                     .per(15)
    render json: @languages.to_json
  end

  # GET /languages/:id
  def show
    @language = Language.where(id: params[:id])
                    .first
    if @language != nil
      render json: @language.to_json
    else
      render json: {
          error: "No such language; check the id",
          status: 404
      }, status: 404
    end
  end
end