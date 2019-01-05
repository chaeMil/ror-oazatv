class Api::V1::VideosController < ApplicationController

  #GET /videos
  def index
    page = params[:page] || 1
    @page = page
    @videos = ArchiveItem
                  .includes(:archive_files, :translations)
                  .select(:hash_id, :date, :tags, :created_at, :updated_at, :views, :title, :description)
                  .order(date: :desc)
                  .where(published: true)
                  .page(page).per(15)
    render json: @videos.to_json(include: [:archive_files, :translations], except: [:note, :published])
  end

  # GET /videos/:id
  def show
    hash_id = params[:id] || nil
    p params
    @video = ArchiveItem.where(published: true)
                 .includes(:archive_files, :translations)
                 .select(:hash_id, :date, :tags, :created_at, :updated_at, :views, :title, :description)
                 .where(hash_id: hash_id)
                 .first
    if @video != nil
      render json: @video.to_json(include: [:archive_files, :translations], except: [:note, :published])
    else
      render json: {
          error: "No such video; check the hash id",
          status: 404
      }, status: 404
    end
  end
end