class Api::V1::CategoriesController < ApplicationController

  #GET /categories
  def index
    page = params[:page] || 1
    @page = page
    @categories = Category.includes(:translations)
                      .page(page)
                      .per(15)
    render json: @categories.to_json(include: [:translations])
  end

  # GET /categories/:id
  def show
    @category = Category.includes(:translations)
                    .where(id: params[:id])
                    .first
    if @category != nil
      render json: @category.to_json(include: [:translations])
    else
      render json: {
          error: "No such category; check the id",
          status: 404
      }, status: 404
    end
  end
end