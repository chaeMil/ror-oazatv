class HomeController < ApplicationController
  def index
    @latest_videos = ArchiveItem.last(10)
  end
end