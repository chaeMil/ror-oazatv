class HomeController < ApplicationController
  def index
    @latest_videos = ArchiveItem
                         .order(date: :desc)
                         .where(published: true)
                         .limit(10)
    @categories = Category.all
  end
end