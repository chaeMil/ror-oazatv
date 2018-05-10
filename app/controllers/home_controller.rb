class HomeController < ApplicationController
  def index
    @latest_videos = ArchiveItem
                         .order(date: :desc)
                         .where(published: true)
                         .includes(:archive_files, :translations)
                         .limit(10)
    @categories = Category.all.includes(:translations)
    popular_video_ids = VideoWatch.popular_video_ids
    @popular_videos = ArchiveItem.where(published: true)
                          .where(hash_id: popular_video_ids.keys)
                          .order('views desc')
  end
end