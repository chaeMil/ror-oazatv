class Api::V3::CategoriesController < ApplicationController

  #GET /categories
  def index
    @page = params[:page] || 1
    @categories = Category.includes(:translations)
                      .page(@page)
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

  # GET /categories/:id/videos
  def videos_in_category
    @page = params[:page] || 1
    @category_id = params[:id]
    @videos = ArchiveItem
                  .includes(:archive_files, :translations, :categories, archive_files: [:language])
                  .select(:hash_id, :date, :tags, :created_at, :updated_at, :views, :title, :description)
                  .order(date: :desc)
                  .where(published: true, categories: {id: @category_id})
                  .page(@page)
                  .per(15)
    render json: @videos.to_json(:include => {:translations => {}, :archive_files => {:include => :language}},
                                 except: [:note, :published])
  end
end