class HomeController < ApplicationController
  def index
    @latest_videos = ArchiveItem
                         .order(date: :desc)
                         .where(published: true)
                         .includes(:archive_files, :translations)
                         .limit(10)
    @categories = Category.all.includes(:translations)
  end
end