class Api::V3::VideosController < ApplicationController

  # GET /videos
  def index
    page = params[:page] || 1
    @page = page
    @languages = Language.all
    @videos = ArchiveItem
                  .includes(:archive_files, :translations, archive_files: [:language])
                  .select(:hash_id, :date, :tags, :created_at, :updated_at, :views, :title, :description)
                  .order(date: :desc)
                  .where(published: true)
                  .page(page)
                  .per(15)
    @videos.each do |video|
      video.archive_files.each do |archive_file|
        @languages.each do |language|
          if language.id == archive_file.id
            archive_file.language = language
          end
        end
      end
    end
    render json: @videos.to_json(:include => {:translations => {}, :archive_files => {:include => :language}},
                                 except: [:note, :published])
  end

  # GET /videos/:id
  def show
    hash_id = params[:id] || nil
    @video = ArchiveItem.where(published: true)
                 .includes(:archive_files, :translations)
                 .select(:hash_id, :date, :tags, :created_at, :updated_at, :views, :title, :description)
                 .where(hash_id: hash_id)
                 .first
    if @video != nil
      render json: @video.to_json(:include => {:translations => {}, :archive_files => {:include => :language}},
                                  except: [:note, :published])
    else
      render json: {
          error: "No such video; check the hash id",
          status: 404
      }, status: 404
    end
  end

  # GET /videos/popular
  def popular
    popular_video_ids = VideoWatch.popular_video_ids
    @popular_videos = ArchiveItem.where(published: true)
                          .where(hash_id: popular_video_ids.keys)
                          .order('views desc')
    render json: @popular_videos.to_json(:include => {:translations => {}, :archive_files => {:include => :language}},
                                         except: [:note, :published])
  end
end