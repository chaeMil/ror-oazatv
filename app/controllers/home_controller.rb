class HomeController < ApplicationController
  def index
    @latest_videos = ArchiveItem.where(published: true).last(10);

  end
end