class VideoController < ApplicationController
  before_action :set_archive_item, only: %i[watch]

  def watch
    if @video.published
      count_view
      @similar_videos = similar_videos
    else
      raise ActionController::RoutingError.new('This video is not available')
      #TODO do something nicer
    end
  end

  private

  def count_view
    cookie_name = "watch_#{@video.hash_id}"
    if cookies[cookie_name].nil?
      @video.increment(:views, 1)
      @video.save
      video_watch = VideoWatch.new(video_hash_id: @video.hash_id)
      video_watch.save
      cookies[cookie_name] = {value: 'watched', expires: Time.now + 1 * 60 * 60}
      #count view again after one hour
    end
  end

  def similar_videos
    tags_array = @video.tags.split(",").map(&:strip)
    #p ArchiveItem.where('tags iLIKE ANY ( array[?] )', tags_array)
  end

  def set_archive_item
    @video = ArchiveItem
                 .where("hash_id = '#{params[:hash_id]}'")
                 .first
  end
end