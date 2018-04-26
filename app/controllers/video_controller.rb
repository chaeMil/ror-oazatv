class VideoController < ApplicationController
  before_action :set_archive_item, only: %i[watch]

  def watch
    unless @video.published
      raise ActionController::RoutingError.new('This video is not available')
      #TODO do something nicer
    end
  end

  private
  def set_archive_item
    @video = ArchiveItem.where("hash_id = '#{params[:hash_id]}'").first
  end
end